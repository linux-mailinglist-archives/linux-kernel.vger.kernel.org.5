Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC8760399
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjGYAKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGYAKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:10:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A650171E;
        Mon, 24 Jul 2023 17:10:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8b2b60731so25737675ad.2;
        Mon, 24 Jul 2023 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690243807; x=1690848607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf+PzXduxiuJ48KWawZ3LtkdVEPJb3KLiKU+A4/q/2Q=;
        b=Nwak+FBzHWKFDHev4q7rUdCqtjOpRdeo8NZ7uewmPCm1t8Fc/f898eg2UPv/lkF2zT
         kUo19a/Fr1oVZ644KlIMpDycApZmVe0nxCdQxWqTiR18zd0heFmNDkASykhFTYzmMXcZ
         m3bhxyp1/xORSc64j9NKNMWSLgwhnyktIyzI890T2BoWTGMKwOx0EUoXaTEA9F1nB5m0
         p1rjyztq2FzyYVWtAwR4UqHPTJb5Q6AcmQ3D4YsVCZE1AmIDvTW7W6CYUO6aQlSzMrWt
         xC+CA4tXHhXqy7KNJlOx2elZlcY0cKA1bZJW8Ud7n++QdJPKY7Jf5FjpocKQUEfZIuzG
         N5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690243807; x=1690848607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf+PzXduxiuJ48KWawZ3LtkdVEPJb3KLiKU+A4/q/2Q=;
        b=Z8ABkU/QwWVBH2u5EDnBlOWxwqX8xY8NSB92F81IiSaZEfN2tNRNW4YPQ+eaByT6aV
         M2tDy/eshalkzwvXiCPpYmXRR0BkueUeMSMqZzuSV/46qdhKSkTZH6OejUbyFuyLizBc
         VEg2oGtlX55GjCTT3wRex3WflPR2663liRdpBnBdN0peXActPOKtBy0hX4LQufJ6stop
         jzP/4XKxdYqaNhv+uhtKHdoHVb43k5Y4etWk6ypYIGRqptqC3hqS6ApTGwSnrKAy9kkx
         tjSe2vmkAX103HOvaAKf5HAvf9l0X2LyMTOJqtuhjsHV4JRzfBHAZpVrZ+m0OVKdQ0gH
         vgVQ==
X-Gm-Message-State: ABy/qLahXtfYdt9iAwmqrDmhnr3xNs5fpGgIYv0mQmpzUsnc+bcNTS1R
        WL3Lm8qYfdMOGjG5rAUPauw=
X-Google-Smtp-Source: APBJJlFQDcA1kqMEZOG673r5dxMQmDtqfPe2bqvQzV4rQfkTn5yubhCV2ENLPI25inl8aF8V5TdnjA==
X-Received: by 2002:a17:902:9b98:b0:1b9:e9f1:91e0 with SMTP id y24-20020a1709029b9800b001b9e9f191e0mr7323365plp.41.1690243806657;
        Mon, 24 Jul 2023 17:10:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9d8f:da31:e274:eeb5])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b001b04b1bd774sm9570519plx.208.2023.07.24.17.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 17:10:06 -0700 (PDT)
Date:   Mon, 24 Jul 2023 17:10:03 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Henrik Rydberg <rydberg@bitmath.org>,
        Verot <verot.wrongdoer713@simplelogin.com>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: Kernel 6.4.4 breaks Elan Touchpad 1206
Message-ID: <ZL8S2/Ujprk4KgzT@google.com>
References: <42bc8e02-5ee0-f1c8-610e-e16391e54ee2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42bc8e02-5ee0-f1c8-610e-e16391e54ee2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:00:21AM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > Description:
> > When booting into Linux 6.4.4, system no longer recognizes touchpad input (confirmed with xinput). On the lts release, 6.1.39, the input is still recognized.
> > 
> > Additional info:
> > * package version(s): Linux 6.4.4, 6.1.39
> > * Device: ELAN1206:00 04F3:30F1 Touchpad
> > 
> > Steps to reproduce:
> > - Install 6.4.4 with Elan Touchpad 1206
> > - Reboot
> > 
> > The issue might be related to bisected commit id: 7b63a88bb62ba2ddf5fcd956be85fe46624628b9
> > This is the only recent commit related to Elantech drivers I've noticed that may have broken the input.
> 
> See Bugzilla for the full thread:
> 
> To the reporter (Verot): Can you attach dmesg and lspci output?
> 
> Anyway, I'm adding this regression to be tracked by regzbot:
> 
> #regzbot introduced: 7b63a88bb62ba2 https://bugzilla.kernel.org/show_bug.cgi?id=217701
> #regzbot title: OOB protocol access fix breaks Elan Touchpad 1206

Please don't as ELAN1206:00 04F3:30F1 looks like I2C-HID and not PS/2
device that 7b63a88bb62ba2 would affect.

Thanks.

-- 
Dmitry
