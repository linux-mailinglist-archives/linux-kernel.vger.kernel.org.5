Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1401C7F7226
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345669AbjKXK4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjKXK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41621BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700823410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4lIC23ZyZLJj/oYUj3wwJ9PbugdSurQXfcrH9U9VfYw=;
        b=KzBRBjPn75EPFXQmrdZAcao9Prerc8uwlwuXbMKBPGCjHqAFwrB1JkZrJAeZg1yph9BnaJ
        08h9tZxDQmauS9+CeW2UyVdmgWa7XjIN985aA29Idh9PXT6ylSUfRwMAJk+a8i7goanMbW
        6TGGjd8PE0WfJsK2AY05KYadrLIntOQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-NsVXo1yWOFWYq3K3MvF0XA-1; Fri, 24 Nov 2023 05:56:49 -0500
X-MC-Unique: NsVXo1yWOFWYq3K3MvF0XA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332c6dc8b5cso1024168f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700823408; x=1701428208;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lIC23ZyZLJj/oYUj3wwJ9PbugdSurQXfcrH9U9VfYw=;
        b=O8QTsDHeaJjppV8KnvMUksGnTav4GnvtM4si71ew0PM60/5EaAD9P8ra1bDe8dp80l
         1gFf4plZFMgX5c6phPauuAXUkpCUBusQLH5gx4rin/rdyqfUSfC6262Ifyr/g0MAhy+B
         vQgF7GDprfcUJjIQjJ9LoOa5AwtQGSkEvmwYLWbr1kibsw/RsXdLiOXyjvlJjPGVCuVC
         ydQBgv/F7VaGH8JOSpTFatkXbGfWzkhOFNYKeGrxmzT/LSNk2FbsBkBG1LHgOfu1jt33
         v5J6PKIcoz119TE+et6o2Di1mOpS8XMaey/NPHeIpKWhW+kTPeopbkVZzWx963uPo5O/
         UTaQ==
X-Gm-Message-State: AOJu0YzVecXj99+awQhrumGxSaDHuFSMK6FJExZB/3ROZtLuQ/PWuyb3
        ZvI/2/ewb2LTFG62qMAM8ct3SEKbJYDOHLffWhpgBrBrLF3XdBmCoP6hJF6Dr7jHVl9rHQ9gQX5
        l1Zqp74il0uPXWFk/LeHF2M69
X-Received: by 2002:adf:b1d5:0:b0:32d:aa11:221d with SMTP id r21-20020adfb1d5000000b0032daa11221dmr1609072wra.27.1700823408232;
        Fri, 24 Nov 2023 02:56:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8B1Z5Xh4NJM4v+jFXHb5dS3jyH1zOINaNv+9ttW9vntLWVjkhOG5VMvKimijwhgUpy+ZIgA==
X-Received: by 2002:adf:b1d5:0:b0:32d:aa11:221d with SMTP id r21-20020adfb1d5000000b0032daa11221dmr1609038wra.27.1700823407919;
        Fri, 24 Nov 2023 02:56:47 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i2-20020adffc02000000b00327de0173f6sm4052394wrr.115.2023.11.24.02.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:56:47 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
        zackr@vmware.com, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@gmail.com>, banackm@vmware.com,
        Rob Clark <robdclark@gmail.com>, krastevm@vmware.com,
        spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mombasawalam@vmware.com,
        Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
In-Reply-To: <xUgaKXv4lqgCEWWlB4KRGx-yLXefTg-uXEdXaTqAhOTxC4G7bCILTK9SH6ymdmMMBLooAl3_Kdvl5JXeUA8Hofg9PcCMBhPWhVhnCoxvgqA=@emersion.fr>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr>
 <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
 <87y1eqc5qk.fsf@minerva.mail-host-address-is-not-set>
 <xUgaKXv4lqgCEWWlB4KRGx-yLXefTg-uXEdXaTqAhOTxC4G7bCILTK9SH6ymdmMMBLooAl3_Kdvl5JXeUA8Hofg9PcCMBhPWhVhnCoxvgqA=@emersion.fr>
Date:   Fri, 24 Nov 2023 11:56:46 +0100
Message-ID: <87leanctch.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Ser <contact@emersion.fr> writes:

Hello Simon,

> On Wednesday, November 22nd, 2023 at 13:49, Javier Martinez Canillas <javierm@redhat.com> wrote:
>
>> Any objections to merge the series ?
>
> No objections from me :)
>

Perfect, I'll merge this series then to unblock the mutter MR. Thanks again!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

