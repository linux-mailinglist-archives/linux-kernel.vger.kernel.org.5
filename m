Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFFB7D8BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbjJZWZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJZWZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:25:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB63CC;
        Thu, 26 Oct 2023 15:25:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c5071165d5so16356571fa.0;
        Thu, 26 Oct 2023 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698359152; x=1698963952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5p4Mh/OXx/If7dQQRvDkjUM/vaepawDRdGrZy7iw80=;
        b=TFADJU8LlltSRY6oRRLSdOJuohgM7xs+qDop6j+upcYoZlCuAmBkeRluQ5avd2iiSB
         JUNdkXUJwjbdP7DPYHZRS5AsY3zqDgOqZlnfubbkoWja+C4kVmzGz+j8lfZR+mKogJcE
         1M/+6tlLB7ftq2eAIj7nVKs69zPgEtisWI72z0p0Bzjnu3DtOKgiDwdblTIC9psNulR6
         5MmZTIbvH7+ZYe7H8o43CS/jBUlfjByqsgc3EyYsto43e54t90JXPnFS3lOhZ4imdJ8u
         ibM5YX/VAQswbWWu7WTJZIR/+2DDT2bpXFpIAKM2nLX3bSjwH/wkl7OA7y2Kdkmz8qhz
         tcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698359152; x=1698963952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5p4Mh/OXx/If7dQQRvDkjUM/vaepawDRdGrZy7iw80=;
        b=Dis/y4+BLOe/XIb2LxOZTymfeJHqk9EkyP5rZwixzYZ0t0Nh+vq7YtA+c8vmZihJ4W
         cT1u21MyJCto/Zm1nrfKJ/l/qOspiWI0JzpJaerAlwtC4GS6HSpkhhpKEnZ/FG0G12An
         lTGDPRvhV0WeLosfeWkvA1goqjBlbmZcDMOqTpna1lW80zNF1BSwkUxtFjM9reZxZ+r6
         1a1cZ/i/wR1x9kpmt5rb46DeL2lhghw9FnYXS65hVH6HvNpNEyKBCXik7z5clYMV3cU4
         sqLHsKsEjWiW9nh2rwtWqp7eZi9WiWdyMGDHPz1UWoUgBToM77HzmgzyPYrbVwX+A10W
         iGTQ==
X-Gm-Message-State: AOJu0Yzh7KVL4sE04dQ69eegXzCvgR9x/lBcUEVO8G2NB5ouDV5sj+r0
        26++CaneO6kHpjVDgeG9eOg=
X-Google-Smtp-Source: AGHT+IEo8OAfPWEktKMivKvhtgoDHKwvxythYXL179zpbTtMYmD2w6YdRdxd0nPaYjk3FRGKDLz64g==
X-Received: by 2002:a2e:8295:0:b0:2c5:1d95:f7a1 with SMTP id y21-20020a2e8295000000b002c51d95f7a1mr708686ljg.27.1698359152188;
        Thu, 26 Oct 2023 15:25:52 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id er14-20020a05600c84ce00b004064cd71aa8sm106688wmb.34.2023.10.26.15.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:25:50 -0700 (PDT)
Date:   Fri, 27 Oct 2023 01:25:48 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     GR-Linux-NIC-Dev@marvell.com, UNGLinuxDriver@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH next v2 1/3] ethtool: Implement ethtool_puts()
Message-ID: <20231026222548.rqbp5ktgo2mysl6w@skbuf>
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-1-0d67cbdd0538@google.com>
 <20231026220248.blgf7kgt5fkkbg7f@skbuf>
 <CAFhGd8rWOE8zGFCdjM6i8H3TP8q5BFFxMGCk0n-nmLmjHojefg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8rWOE8zGFCdjM6i8H3TP8q5BFFxMGCk0n-nmLmjHojefg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 03:09:59PM -0700, Justin Stitt wrote:
> Should I undo this? I want my patch against next since it's targeting
> some stuff in-flight over there. BUT, I also want ethtool_puts() to be
> directly below ethtool_sprintf() in the source code. What to do?

(removing everyone except the lists from CC, I don't want to go to email
arest because of spamming too many recipients)

What is the stuff in-flight in next that this is targeting?

And why would anything prevent you from putting ethtool_puts() directly
below ethtool_sprintf()?
