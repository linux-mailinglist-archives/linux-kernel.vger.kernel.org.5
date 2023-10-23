Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C557D3E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjJWSDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjJWSDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:03:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CBDB4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:03:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cac80292aeso19751665ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698084194; x=1698688994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=arV3WvwMGkVwizBfpgtp9qoHNsxotQwpgBb6OnpwjQI=;
        b=G2vbIiTwgvKjW4QilPTMiM9Uz2YF2WKxk6dY6fqoDkc5Lb1WNjVBeTLPqJc/BryPdW
         ISjJ7q8/qP2gvFYEpBEWIi+8xJi2SwrZnwdkRRXwybKZ65+TeG8eHwj41VMTv57LXoRD
         bmyaPKEO9aPOjWMoydK/eWHQMkkLW1d5S0SHfAFv+XjjUwUvtw0c9oKQyg+PxSYX4pCo
         uT7MnbZ2Rf77SiRfGeJnkuuJEXetHWl9P7G5FbrW3ALSwufAD2ypa8+kze9rm2Z2xIa8
         2bvLltF6ehd5kpONCoOrxSJcfaZjaezxqVXjUQxnUMl3d8HDNdbBCSWA/U6lFRhsVlbK
         bQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084194; x=1698688994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arV3WvwMGkVwizBfpgtp9qoHNsxotQwpgBb6OnpwjQI=;
        b=cxTozpGY7n9uL2mD7vN/EpNOzPYQxICcKw4nDuCmohgrtUGKMgqUuBN1n2fR4Rl6Fd
         3htRNiv/heBFRcfN3NBsfT6Hi3kwQghbHbrlhmGK9dTsfeoTKC2/0w2/XVjwHfFqyvS7
         P3ffsGIetemS96AEJdlFTojQtcWNVno6myYtX36OBxJb6kAaRIxP2VbonewlQClhrsrT
         rUOvIeFg5Gxvl7YtpF6Xu4lyKSS/GffsA+JGlpQvWiv4tFLf9bCC8U5DSmb3W2h2GYXb
         HM3No12ENpeHEOsHofdK023jiFy0rBGRsjdCGC53pKJr6KyvGSVAT2OIJwZD+WWXe/XZ
         IzsA==
X-Gm-Message-State: AOJu0Yy/jj9R+o5df8MxDa2lP+yilRFL38/E/NmIhuKjnUgLJPgJQdxs
        vycnrEzMeM0HHelgcP4DxhVLtA==
X-Google-Smtp-Source: AGHT+IFqDzcfSPSj6ToWBgpfG/3z9qkyMrDNHGYQJ5K5TCb2lJU2I3IY/Qp9PsSJ/FDNmIuZzk9wxA==
X-Received: by 2002:a17:902:dac9:b0:1ca:9415:a50d with SMTP id q9-20020a170902dac900b001ca9415a50dmr9099665plx.2.1698084194201;
        Mon, 23 Oct 2023 11:03:14 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:85b7:8283:12b2:30f8])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001b8a2edab6asm6182119plh.244.2023.10.23.11.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:03:13 -0700 (PDT)
Date:   Mon, 23 Oct 2023 12:03:11 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rpmsg: virtio: replace deprecated strncpy with
 strscpy/_pad
Message-ID: <ZTa1XwYnNKPH+voo@p14s>
References: <20231021-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-v1-1-8abb919cbe24@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-v1-1-8abb919cbe24@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

On Sat, Oct 21, 2023 at 12:09:16AM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This patch replaces 3 callsites of strncpy().
> 
> The first two populate the destination buffer `nsm.name` -- which we
> expect to be NUL-terminated based on their use with format strings.
> 
> Firstly, as I understand it, virtio_rpmsg_announce_create() creates an
> rpmsg_ns_msg and sends via:
> 
> virtio_rpmsg_bus.c:
> 336: err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
> 
> ... which uses:
> virtio_rpmsg_sendto() -> rpmsg_send_offchannel_raw()
> 
> ... which copies its data into an rpmsg_hdr `msg` in virtio_rpmsg_bus.c
> 618: memcpy(msg->data, data, len);
> 
> ... and we end up receiving here via a callback:
>

Function rpmsg_ns_cb() is called when a message is received from the remote
processor and not on the downward path from rpmsg_send_offchannel_raw().  I am
good with the code modification but the changelog needs to be amended.

> rpmsg_ns.c:
> 30: /* invoked when a name service announcement arrives */
> 31: static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> 32: 		       void *priv, u32 src)
> 33: {
> 34:         struct rpmsg_ns_msg *msg = data;
> ...
> 50:         /* don't trust the remote processor for null terminating the name */
> 51:         msg->name[RPMSG_NAME_SIZE - 1] = '\0';
> 
> ... which finally leads into the use of `name` within a format string:
> rpmsg_ns.c:
> 57: dev_info(dev, "%sing channel %s addr 0x%x\n",
> 58:          rpmsg32_to_cpu(rpdev, msg->flags) & RPMSG_NS_DESTROY ?
> 59:          "destroy" : "creat", msg->name, chinfo.dst);
> 
> Taking another look at this comment + NUL-byte assignment:
> 50: /* don't trust the remote processor for null terminating the name */
> 51: msg->name[RPMSG_NAME_SIZE - 1] = '\0';
> 
> ...  we probably _can_ trust that this string is NUL-terminated with the
> introduction of strscpy(). However, since there might be some magic
> happening between the announcement create and the callback that I don't
> understand, I've opted to leave this comment and assignment alone as it
> doesn't hurt.
> 
> We can also observe that `nsm` is not zero-initialized and as such we
> should maintain the NUL-padding behavior that strncpy() provides:
> 
> virtio_rpmsg_bus.c:
> 330: struct rpmsg_ns_msg nsm;
> 
> Considering the above, a suitable replacement is `strscpy_pad` due to
> the fact that it guarantees both NUL-termination and NUL-padding on the
> destination buffer.
> 
> Now, for the third and final destination buffer rpdev->id.name we can
> just go for strscpy() (not _pad()) as rpdev points to &vch->rpdev:
> |       rpdev = &vch->rpdev;
> 
> ... and vch is zero-allocated:
> |       vch = kzalloc(sizeof(*vch), GFP_KERNEL);
> 
> ... this renders any additional NUL-byte assignments (like the ones
> strncpy() or strscpy_pad() does) redundant.

I agree with the above rational.

Thanks,
Mathieu

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 905ac7910c98..dc87965f8164 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -329,7 +329,7 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
>  	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
>  		struct rpmsg_ns_msg nsm;
>  
> -		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
> +		strscpy_pad(nsm.name, rpdev->id.name, sizeof(nsm.name));
>  		nsm.addr = cpu_to_rpmsg32(rpdev, rpdev->ept->addr);
>  		nsm.flags = cpu_to_rpmsg32(rpdev, RPMSG_NS_CREATE);
>  
> @@ -353,7 +353,7 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
>  	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
>  		struct rpmsg_ns_msg nsm;
>  
> -		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
> +		strscpy_pad(nsm.name, rpdev->id.name, sizeof(nsm.name));
>  		nsm.addr = cpu_to_rpmsg32(rpdev, rpdev->ept->addr);
>  		nsm.flags = cpu_to_rpmsg32(rpdev, RPMSG_NS_DESTROY);
>  
> @@ -424,7 +424,7 @@ static struct rpmsg_device *__rpmsg_create_channel(struct virtproc_info *vrp,
>  	 */
>  	rpdev->announce = rpdev->src != RPMSG_ADDR_ANY;
>  
> -	strncpy(rpdev->id.name, chinfo->name, RPMSG_NAME_SIZE);
> +	strscpy(rpdev->id.name, chinfo->name, sizeof(rpdev->id.name));
>  
>  	rpdev->dev.parent = &vrp->vdev->dev;
>  	rpdev->dev.release = virtio_rpmsg_release_device;
> 
> ---
> base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
> change-id: 20231020-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-dba15db4e890
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
