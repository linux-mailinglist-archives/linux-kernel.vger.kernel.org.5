Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7414765B26
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjG0SGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjG0SGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:06:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0830F4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:06:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso14144865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690481188; x=1691085988;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+bW5h+Kxz30xF2bPWY/VHHArmwfKGABhQO7BOKc75k=;
        b=FdPBlsRpibR6Rd31pEbQDC9z2v29mlrpnm5A0/ycmzBocyct7blATYoD9iKob2Pzp7
         Txt71nGgCgeqo0dokiYUCBdO1j9yxOAfEG3agvnZxjddkroDFydEM6bFC3hIlmPbP6oo
         0c9CM4+8/Lv6++sajBadbwZAo/+Wce9RUg4B2UOFtFjhTZS1D4oogEw4fnqCxqyC9Kcc
         lKVD/QKbvMrmvyMEhLpbBPSKZzMSDsPi6IqaJaXg0AWs9UWjsd9Z4UpXFSSOEcDNaDGx
         9r5TxzufbPyGuARsybZIE4NCckuBhA7CpzYWWiCvWmy9T4eoIkqSsVaIj9X8ntrkGZD1
         3+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690481188; x=1691085988;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+bW5h+Kxz30xF2bPWY/VHHArmwfKGABhQO7BOKc75k=;
        b=F9H8Z/l3oF/19bK8CMpV8yh0eMNypQMw9AnBgONFFRypIK3I0Ms/u3ncMR+6VSQVj2
         eJpmTm/yYTG5pqmrcmaY1eAqaNHYh5bByStjZWJKNihYtaJownvgLWnyeWiQRJ76GPWk
         V8CgaBYprzjwXEdu1a71m7yRRQfEM/aFR1/kMt46quZqmz1jshpjIQtxtpD+C8I7Be4m
         UjzT966f8JTiVA1ucfwbXaH+31Snz8nWfn3kepIrFvZ56ggd2dRDaAtZfC7LU/1IJVWT
         JHcqIO1u1KxC69HRtrdkLrv7DeJ+dZrErG/okxi5c+3+o92kkhvojWBFdfsEN+iOM3hF
         Y1IA==
X-Gm-Message-State: ABy/qLZ8LgBs//Aj82MSQfVoI+yAhEKxGPhCJah5FCXlpHVZmC0OEiGc
        kvrJbgZPDpjywM6/4vyyDiHe4XVF0nTX4A==
X-Google-Smtp-Source: APBJJlGBXAgs91RjhxwLg0YUC0Urbov9iw4fIjbJvq+DiZ+8thy59PF4P2fJzsxpEIccKqia7NdM0Q==
X-Received: by 2002:a7b:c8d7:0:b0:3fb:9ef1:34ef with SMTP id f23-20020a7bc8d7000000b003fb9ef134efmr2487020wml.37.1690481187582;
        Thu, 27 Jul 2023 11:06:27 -0700 (PDT)
Received: from torreasustufgamingpro (209.pool90-77-130.dynamic.orange.es. [90.77.130.209])
        by smtp.gmail.com with ESMTPSA id w3-20020a1cf603000000b003fa973e6612sm5123358wmc.44.2023.07.27.11.06.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:06:26 -0700 (PDT)
From:   =?utf-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: I need help to send v2 patch on linux-ext4 at vger.kernel.org
Date:   Thu, 27 Jul 2023 20:06:19 +0200
Message-ID: <877cqlmdpg.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have submitted a patch to linux-ext4 at vger.kernel.org mailing list
and they have responded with whatever changes they think are necessary.

Can someone help me by telling me the steps I need to take to send v2?
I don't know where ask it.

Do I have to create a new branch?

Is modifying the source in the same branch enough?

Do I have to do a git pull on the patch branch before the changes?

Do I have to to commit the changes before running
git format-patch --in-reply-to=3D20230423082349.53474-1-megia.oscar@gmail.c=
om --cover-letter -o outgoing_v2/ master?

--in-reply-to=3D points to the v1 patch cover-letter or v1 1/1 mail?.

Please, is my first time to send a patch version's v2 and I didn't find
any place where explain step by step how to do it.

I tried several steps, but I get errors or resend v1 patch too.

--=20
Regards
Oscar Megia L=C3=B3pez
