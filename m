Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA0791D86
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbjIDTNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjIDTNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:13:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C601189;
        Mon,  4 Sep 2023 12:13:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso25547861fa.0;
        Mon, 04 Sep 2023 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693854822; x=1694459622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6wmCakRtewm2+bJdkn7kR1fHTbKa9QWEP3nUsfbTj4=;
        b=X90fTleoastJiprldBmvC1o9dUu9tgrXxGpLrePj4jvcCsC1N0veYkB6d78R6aEy7i
         jP3UE1cASPxqmGnapiCyiigoU+P2RnJjHasogS5WV3E3xk350zaOKLjcqg2hAyPwTAbY
         M4l5DHfPVks//12Qgu0e9vdawe3UTojV5bGn7/fagf2bZIF8E5vlA3w16FUIoWomVugz
         f6wGsnWswmbmrdD7CygyOdv/vYuxq+z3DaG0uf18WMh+rgQQrArkQAc8ySPxfxx6hf0j
         qOeS+8hpj6w1h9gISQM9IlJEJ92/a1KvnAm6XxmsUCVQYQ2/o2257S3eb4wVJgwnpXZ+
         n3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693854822; x=1694459622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6wmCakRtewm2+bJdkn7kR1fHTbKa9QWEP3nUsfbTj4=;
        b=IN6WthRXJ5eG8JBAmTJRO8+3EXXyvL6V7mAgldScR8tM93HD2zNAVO14JIjV6/ILgA
         NTtpFkHANSBLaTCOQyta9e9LaxCTaDae2hLU+xS7rh3k/lb+tTn1S/jPArfIwO7x1S6Y
         dK3sxzRA45PwOqIxg0XlQNQjbDFXO72cb63EZR2CjVRqAgZDgtGysz5Hqu61zZ84pzkl
         vo6aR1Kx71ajFvU3fkiC6BKM035++s8htzv6YJUsz70H6sKFIBDVaHGgzZEXOCJbUkYa
         m93x0EdinnGMolgeTow5DZ7oEYtkqphctVGcF7fsX7s4elmOE9LVww9ZsFjhzpoW2IHV
         rvbg==
X-Gm-Message-State: AOJu0Yya5ziL632IJVXaU5wFhsu9BhHoj/Cln9AxtuSVmE2Pl9sF7rBN
        mV9jc2bdDmDituxHxYADCC4=
X-Google-Smtp-Source: AGHT+IGSL8PEvYnkWc7GpXRT5MkYfVr5Xn5yQrvz9Pz9JNs6xBuJcq20GtuuK2hqtbLYW3Eul85wSw==
X-Received: by 2002:a2e:888f:0:b0:2b6:de52:357 with SMTP id k15-20020a2e888f000000b002b6de520357mr7955436lji.40.1693854822205;
        Mon, 04 Sep 2023 12:13:42 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id 18-20020a05651c00d200b002b9f4f3e16dsm2329255ljr.85.2023.09.04.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:13:41 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 Sep 2023 21:13:39 +0200
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Marcus Seyfarth <m.seyfarth@gmail.com>, paulmck@kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <ZPYsY2HEjySkq/NR@pc636>
References: <CA+FbhJPOkV4Xa7ZJ4QF2y_-5i24F+TkhByr=LzMPt9iy9EshSQ@mail.gmail.com>
 <4009a6e0-198c-4f25-8e34-4774dcd8c537@paulmck-laptop>
 <CA+FbhJPxU+QKf1tTBd8XcKcSsTeRmJ=ji_L4QYiad--hGqRB5w@mail.gmail.com>
 <bb603efb-654f-4686-bad9-0bb5379745c0@paulmck-laptop>
 <CA+FbhJPtmFG2vKNXWr67Tuh-4HUi8n81PmKxwftv9iK1a3On-A@mail.gmail.com>
 <ZPW+KJCIAvFzZHl8@pc636>
 <CA+FbhJPNZ-E3e7WBH_jAvi3Rn-2gV4TVk9S9qmheXkqXw+Sakg@mail.gmail.com>
 <ZPXyUTteVxXtqiEo@pc636>
 <CA+FbhJMr6LzmOpVNkYyiSERAsNEqqvQwQ7SwJK=CmwvV9d2Z-A@mail.gmail.com>
 <ZPYLmm3ih7u95l1a@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPYLmm3ih7u95l1a@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> https://github.com/ms178/archpkgbuilds/tree/main/packages/linux-cachyos
0001-EEVDF-cachy.patch
0001-arch-x86-Makefile.patch
0001-bore-eevdf.patch
0001-cachyos-base-all.patch
0001-lrng.patch
0001-makefile-clang-ms178.patch
0001-ms178.patch

Is sequence of applying important or there is no dependency?

--
Uladzislau Rezki
