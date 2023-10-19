Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE97D04F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346677AbjJSWjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346679AbjJSWjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:39:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7AE115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:39:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so239042b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697755186; x=1698359986; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk5hgpxDNd4N0lz+8mzHBYcat9RckdgLCs9Hpp0Hrl4=;
        b=kF0XhPbELP6oTvH8kfJrP9mocVPm5ymLVEjHbo2WZHp+JGMMqOzxm/X/f4BhA8vmQc
         j6/bbpiRYIh8ygblKmPxUdOyZpCanOOXKFZ2RqnFudLkhBpG91UfhKRLjhWgWz/7SeKc
         LV1N4WWX9ik6xGcCEQGuesPSAlMfp0FTzVCgfW4gBDO+2MyOb2JPBDvfQbY/RoQSCjCb
         NS+3lDu15s1F+09NK39e+rIZrc/A7zPdL0UAGaVscuK1DMEC23kqYTm7l2Ez7KoLdYaa
         rjTIwr3P1HiynYySBefXaHj4C7GH1u+GEm3cKpVM16RX6C2Yl0sNCzFNzcgsBvqt4l3D
         vH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697755186; x=1698359986;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nk5hgpxDNd4N0lz+8mzHBYcat9RckdgLCs9Hpp0Hrl4=;
        b=V1LKJ7NG7ho/9HGtKx9sfoyK1DittcqoAcQQ9iUzOnS81awHmX7tNr671eOvawPLtJ
         uTLN3jQnjpegpGGlDBQD9NCuqnCpAqcdv9Tf+xwk0AbbX5x/b9+Y36QX5hl4EFJY9esw
         YbYPfQ4lIE83czKfphx9VyEoGh+yXelayZgGGWs2xWIqUTtom46u/hl8SH3UwbVMMBsn
         KLHNvKDxcpyyFa8wzKuw/Xi2msQc47HlvL86mzvexbzDIJBYNcIP/6bR4p/lVQyxh4y7
         rVBNBqwMiXgqYRpHW0RZAPl+nmpgjZ49wU2gRLzTthOfcWQJcw5zYUS+aKZVZXd3QRMk
         9qQg==
X-Gm-Message-State: AOJu0YzuBSBSvhX4IW+P9Zj7FfTiMAsOEBJiknAKJbGw+ehIogYBT0g4
        tYnB8IWA2BHzlX3SqAQkxxsYQw==
X-Google-Smtp-Source: AGHT+IE90P/nVzSPZkpSJdRYwbJEj3N78riHlVw7983RV92yexc9Yl2KuouLz6HteMvs72bJQ5wNIQ==
X-Received: by 2002:a05:6a20:12c7:b0:16b:c20d:f979 with SMTP id v7-20020a056a2012c700b0016bc20df979mr190878pzg.13.1697755186034;
        Thu, 19 Oct 2023 15:39:46 -0700 (PDT)
Received: from ?IPV6:2601:645:8100:1350:e143:75f5:fe6d:948c? ([2601:645:8100:1350:e143:75f5:fe6d:948c])
        by smtp.gmail.com with ESMTPSA id q15-20020a63f94f000000b005b2f3b5d3a4sm256831pgk.24.2023.10.19.15.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 15:39:45 -0700 (PDT)
Message-ID: <4ca94f99-fe07-49c2-adc7-84df519792f5@google.com>
Date:   Thu, 19 Oct 2023 15:39:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>, balbi@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "arakesh@google.com" <arakesh@google.com>,
        "etalvala@google.com" <etalvala@google.com>
From:   Jayant Chowdhary <jchowdhary@google.com>
Subject: [PATCH] usb:gadget:uvc: Add super speed plus descriptors
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the UVC gadget driver doesn't support super speed
plus connections since it doesn't advertise super speed plus descriptors.
This patch re-uses the super speed descriptors for super-speed plus.
As a result, hosts can recognize gadget devices when using a super
speed plus connection.

Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
---
 drivers/usb/gadget/function/f_uvc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 32f2c1645467..fa96306f2209 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -492,6 +492,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 	void *mem;
 
 	switch (speed) {
+	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		uvc_control_desc = uvc->desc.ss_control;
 		uvc_streaming_cls = uvc->desc.ss_streaming;
@@ -536,7 +537,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 	      + uvc_control_ep.bLength + uvc_control_cs_ep.bLength
 	      + uvc_streaming_intf_alt0.bLength;
 
-	if (speed == USB_SPEED_SUPER) {
+	if (speed == USB_SPEED_SUPER || speed == USB_SPEED_SUPER_PLUS) {
 		bytes += uvc_ss_control_comp.bLength;
 		n_desc = 6;
 	} else {
@@ -580,7 +581,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 	uvc_control_header->baInterfaceNr[0] = uvc->streaming_intf;
 
 	UVC_COPY_DESCRIPTOR(mem, dst, &uvc_control_ep);
-	if (speed == USB_SPEED_SUPER)
+	if (speed == USB_SPEED_SUPER || speed == USB_SPEED_SUPER_PLUS)
 		UVC_COPY_DESCRIPTOR(mem, dst, &uvc_ss_control_comp);
 
 	UVC_COPY_DESCRIPTOR(mem, dst, &uvc_control_cs_ep);
@@ -742,7 +743,14 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 			goto error;
 		}
 	}
-
+	if (gadget_is_superspeed_plus(c->cdev->gadget)) {
+		f->ssp_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER_PLUS);
+		if (IS_ERR(f->ssp_descriptors)) {
+			ret = PTR_ERR(f->ssp_descriptors);
+			f->ssp_descriptors = NULL;
+			goto error;
+		}
+	}
 	/* Preallocate control endpoint request. */
 	uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
 	uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);
-- 

