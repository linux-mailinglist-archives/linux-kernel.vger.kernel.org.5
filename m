Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24E17E4DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjKHALw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKHALv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:11:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFF110E5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:11:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso5025341a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699402308; x=1700007108; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5FTMnIkfAnWQrINqJsE9vGOX5Y79juiKePAWCBp2xQ=;
        b=OAe3iG1uwVtJhZrYhNJylZ5P3AqQtBaJi2cBiuQuwALU5Vg1tc5A2BxZlYFHEwWIqk
         yY3Na/BIaFhBeM5SPAvAu3p5JU1h0Pik0Y1I6X8+sjinYZqFG5xi2VI8N/4fwuYZyIC3
         xNSjtVVlBkeBPu6Up2VeC2pPk9roIVzabNRysmgjMoBBgMf1ZU7O+vhQ37qzIZH/itg9
         yiluxFr6hijBI/bJm1Ev2yd8RtiVKNeZgr3LwdDbVcz29zhio45cFZVD3ST757teD40R
         7OYdeY9OZiljB09OQ2JvbvnAXJHPmtJ7nltTtz8XXs6lsoDqpxKA/vs3WZcz5Zot6me3
         I8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699402308; x=1700007108;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o5FTMnIkfAnWQrINqJsE9vGOX5Y79juiKePAWCBp2xQ=;
        b=dW6HFqbyJo95BRuq9/B2kaYtjMsDCYyAfjj5uOH/tPbLZ1JpuyrtCaCtxyhY9R7m8t
         mUrMjXdgMNW546ddmE4HQFwTqPtembkRmiaS3OoIWko9uMZGmYsVNMVMfwmh/kQHqmqc
         L05iFhntShZYVhcJbLbvdj0QjUlajLV04tCYWBXthmCSOrhOcpFgrESTb913FuXqrMQj
         dCHU+qtleZOls7XcwBmKkv0Vm33VA/5scwzsGE1ijJeI8h17ouW4S2N89xRahWlyG5Cx
         HUHigqgLCLxIoeGp1NCN8xug+06dmFEYzC6ZUOL1eNJhXwZ2g2hrH5Wbdj1FEMhNY8n5
         vTIA==
X-Gm-Message-State: AOJu0YzY42RV0VpTgc+IEPgXZPGtCPhCG8Ppb2c9+hQzNmtn7mjFC8Fx
        Iqdpk4UWBGFf+3PMhcgnlUo+LxZHfn8=
X-Google-Smtp-Source: AGHT+IFKm49M/VNzE67GA8NDQr1TupQFHjgD/NPr5R/pbLEg4jII8BqgTf96Oyl2ntsD/3uIsg4c6A==
X-Received: by 2002:a17:90b:4a88:b0:280:1a19:6dd5 with SMTP id lp8-20020a17090b4a8800b002801a196dd5mr219806pjb.36.1699402308282;
        Tue, 07 Nov 2023 16:11:48 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w7-20020a17090aad4700b00280fcbbe774sm352767pjv.10.2023.11.07.16.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 16:11:47 -0800 (PST)
Message-ID: <ad48a0bf-0454-44ee-ae00-eff3f8b66ca6@gmail.com>
Date:   Wed, 8 Nov 2023 07:11:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Christian Hergert <chergert@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, bluescreen_avenger@verizon.net
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: 01f05940a9a75e11a2be64993c44ad8dd06e6e26 causes Wayland servers
 to flicker in non-gl virtio QEMU cards
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> It seems that commit 01f05940a9a75e11a2be64993c44ad8dd06e6e26 introduced an issue impacting wlroots and Weston (possibly others) on QEMU with the virtio card. happens on QEMU, and it happens in virt-manager when I do NOT enable GL. (When GL is ENABLED it seems to be fine oddly)
> 
> It introduces odd flickering, Weston's desktop shell flashes when a new window opens, wlroots also acts odd.
> This is QEMU 8.0.4
> 
> I have narrowed it down to 01f05940a9a75e11a2be64993c44ad8dd06e6e26. Reverting the commit (it still reverts cleanly), and the flicking goes away on a rebuild and this is on Linux 6.6.

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: 01f05940a9a75e https://bugzilla.kernel.org/show_bug.cgi?id=218115
#regzbot title: fb damage clips property enablement causes Wayland non-GL flickering on QEMU

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218115

-- 
An old man doll... just what I always wanted! - Clara
