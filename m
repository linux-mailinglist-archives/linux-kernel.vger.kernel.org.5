Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7679B77BF3C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjHNRrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjHNRrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:47:25 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C0B10D0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:47:25 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-56c85b723cfso2934343eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692035244; x=1692640044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/yNh4F2KqOT+gKhbfMAb20rsFiF8tD3IHTN/BfkK/o=;
        b=Nnz1d6Q95SoJZqyUmSGv/mULK+qIzASlvU7AAxuOXr7Ap6igT/sLL3+gSSpHpkoB9d
         nq0FRws0EU8HEIf/UAzptDEUWGEE34uxX7M7wdemum4vt+i8XK0yjWpnP6k6RLQOlYca
         dPoCaU+Az0Ez4ogVRalWR9rBLicAI0FE3KQlaJxmfFUU4xsacst0OFvU4PfESdDv6C0v
         rfdVU0Y3kbPD1Wx43UulHldGLfwHHgUYZeqWz8Gin+PoN2qtQ0YA5Zq2OVexuPN5Afyl
         oUMNjZX2i9gx+2K9cvLivBoiioPUR77MotF6WQlXmHva4gC2yxzxZ617LoiIvIfsnM8b
         F1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692035244; x=1692640044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/yNh4F2KqOT+gKhbfMAb20rsFiF8tD3IHTN/BfkK/o=;
        b=Wd4lM2vGdXxTstdtH4zXRkLMwhaTBQGHeMp8oLMi1xFbEQLRP+YBiUnwu3WyE6vA5s
         cIQR2ObJFbSmdXVz0EeN1gJ9fLntJUc0ndiQuQv4uU+DPBzZQDaepXDgaOODVNv+BJcf
         ZsQKNGchNRB0gKTk+8n/2P4j04IcXu/zBqu9prieUDpeT4EQcbNH09IYFYMXv+F5PCWX
         NPJfYl1H/qgThxmZVmKvKOI5yhhw+Nh7+wSQYJEUk/HvJGdehRj4p+OP7htO5XPAMYRz
         G6UaPJZbGKcELN8fu7PEtFHp+X7zGaiM2amHXaKzhuyZKoy5edtT9ZiAGJCNvCNXhnv4
         xtCg==
X-Gm-Message-State: AOJu0YyAFCmKBVX2U8iVk0hdgNIhLQtCU0FM86m7NbwNQMRF/JnrWfy6
        q+w9o7LFALiof5d1yCta/VRZQg==
X-Google-Smtp-Source: AGHT+IHKtophzNepnrOSKqJW2gtkKecjEJCHZKJbB96GaU/SIQr5jKKtpBh+9NCgIHhPr2b3svWbtQ==
X-Received: by 2002:a05:6358:c15:b0:129:c477:289c with SMTP id f21-20020a0563580c1500b00129c477289cmr8037336rwj.26.1692035244459;
        Mon, 14 Aug 2023 10:47:24 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 11-20020ac8564b000000b003ef189ffa82sm3228482qtt.90.2023.08.14.10.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 10:47:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qVbf1-0070BL-2Q;
        Mon, 14 Aug 2023 14:47:23 -0300
Date:   Mon, 14 Aug 2023 14:47:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     kvm@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/4] vfio: trivially use __aligned_u64 for ioctl structs
Message-ID: <ZNpoq7emI19fApND@ziepe.ca>
References: <20230809210248.2898981-1-stefanha@redhat.com>
 <20230809210248.2898981-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809210248.2898981-2-stefanha@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 05:02:45PM -0400, Stefan Hajnoczi wrote:
> u64 alignment behaves differently depending on the architecture and so
> <uapi/linux/types.h> offers __aligned_u64 to achieve consistent behavior
> in kernel<->userspace ABIs.
> 
> There are structs in <uapi/linux/vfio.h> that can trivially be updated
> to __aligned_u64 because the struct sizes are multiples of 8 bytes.
> There is no change in memory layout on any CPU architecture and
> therefore this change is safe.
> 
> The commits that follow this one handle the trickier cases where
> explanation about ABI breakage is necessary.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/uapi/linux/vfio.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
