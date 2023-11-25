Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB977F8866
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 06:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKYFB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 00:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYFB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 00:01:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B6BE0;
        Fri, 24 Nov 2023 21:02:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28041176e77so1957000a91.0;
        Fri, 24 Nov 2023 21:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700888522; x=1701493322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zU4LUKVhSEBAEyImAqsIdHza582cUZbQQkgImwexMQ=;
        b=ejhKSaZDKY23TXQ7SSUVMm2FOyURMI5nhwa0G1Y8QDgM5G3DMxtIzBSuLw8AGEDpXG
         dODzlfdjwklAlKM3fZzhPgfxLLhaRRlZ8MH6AJdyjIqql+aw/bchYBEn5UDYEcr8mSYM
         kuJ6Y4nTX2DTzcf2Nj0YvbrnLe/TLuWR/QLmrIlDCAOPKyI3MfBC6HLmebgqd2LAzLpz
         4HHGiKrhNrfQRX/WGyQlV+6KmaSZ5M7i5cyo6yWJzKwZ5G91gjVoXJlPw4TMkGmJ6Q99
         /Vo5iBNbFbkGmoTH6utj9cPjtVzWwfctp2JAWTPeCAZK9kmmPMbPFh0/9fzTxMt5owO7
         8dPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700888522; x=1701493322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zU4LUKVhSEBAEyImAqsIdHza582cUZbQQkgImwexMQ=;
        b=Ol4kHlI0uLBPERGMd7SNOWSIxi6xXSuLZi5hkUvZRa8TzKMo2Ia/sU8O+pIY0zrUG7
         erVkthRhqUzOgXeSU6O5WmJC00aFh8zlaFUdG8FqJYkArtwJF/nuvjoaI/0bvZO98Jr8
         tKO+ru1jYyIZ7hNZckhj+5/2xSN+VRSAqSlm26x4SsSrBWC9NLUijzj5Gd6buIcCRAMQ
         gk230Gzc++jwbju43xDRaYrh3jIfzvg1R4rWeXfSVp5MocF/nK1Pv1FfZ2JBh3XP8l/n
         85GxqYiynuYOujCYdlHIgqTJSlb1Jwj+JzhAQYFpx+FksqzK6xNAjVN0mRoNMTfH2iRp
         rmbw==
X-Gm-Message-State: AOJu0YyX1jbOqTNUTCiaRL3uUB4uHfZLf0i6ga4OTqi78f8cW3hkNDz7
        uI3OtMA3GYStgTWhsixgPNkI6eOX53M=
X-Google-Smtp-Source: AGHT+IG1IDjtyfsrrILxO18zuVqQT7XqP8yMv76aZUE10M3VFt0iss8rhyKJKH/e41UIHwf3Slp0HQ==
X-Received: by 2002:a17:903:228c:b0:1cc:ec21:9a64 with SMTP id b12-20020a170903228c00b001ccec219a64mr5277780plh.17.1700888521800;
        Fri, 24 Nov 2023 21:02:01 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:8b5c:82d0:578f:d0])
        by smtp.gmail.com with ESMTPSA id ba8-20020a170902720800b001c7443d0890sm4029794plb.102.2023.11.24.21.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 21:02:01 -0800 (PST)
Date:   Fri, 24 Nov 2023 21:01:58 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alexey Makhalov <amakhalov@vmware.com>
Cc:     linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.co,
        bp@alien8.d, mingo@redhat.com, tglx@linutronix.de,
        zackr@vmware.com, timothym@vmware.com,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, netdev@vger.kernel.org,
        richardcochran@gmail.com, linux-input@vger.kernel.org,
        linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        namit@vmware.com, akaher@vmware.com, jsipek@vmware.com
Subject: Re: [PATCH 4/6] input/vmmouse: Use vmware_hypercall API
Message-ID: <ZWF_xnotegtBElA5@google.com>
References: <20231122233058.185601-1-amakhalov@vmware.com>
 <20231122233058.185601-5-amakhalov@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122233058.185601-5-amakhalov@vmware.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 03:30:49PM -0800, Alexey Makhalov wrote:
> Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
> Eliminate arch specific code. No functional changes intended.
> 
> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry
