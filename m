Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3E7D88E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjJZT3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZT3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:29:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA6E12A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:29:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso34425ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698348545; x=1698953345; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab9IO7fXt9TdvpC/uutKUevV50e6+HBvpHH0PXTYXkE=;
        b=pG99jf2OW3a6SMkjK3YfjzfWplc0D+eajN32lATcTNywDl9uCeR2R9GMsDadJixBlU
         Ai8tiZu0xPFJZQ9zJJTULb2qqJ88u5kTSg6sqRLDXXgGK0xnmj8kS9XDwNFdbkmJN134
         HW2QZ56SjY2GK+0izztiLHxtR65J8RX+dDU/JXy/QhjCgFT2r/IWS+X0SHOD5IrsHIbp
         Br/lnfgQKYEOfip6dh4f+lhHgWPdfzFrTchVX4y8PTAdTNozYKzlIyPgI+xjkxsdlyt0
         2XXR1bEfbNmm4ODZijartnYSFcf9bkXyfsfadUm6BwFwoLtFDYReSUww3m56t7EWwDkm
         3hOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698348545; x=1698953345;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ab9IO7fXt9TdvpC/uutKUevV50e6+HBvpHH0PXTYXkE=;
        b=oVmoCUK8WwMm4WAotVN4o2KDQgP6T5NoZDkA7TuE2/5aruqQssUsVuIBg0UlHOTHiD
         q4s0Crh6OanIJ65jjkpWjeHmwKsm8UWX1UzaCxseZ0+EcrjtlLtlq71OtLhQm42CX8Gx
         8gAmure17WcKPylcSRGSU9d23OgEb6clYpH2mxN88mWiRaKmqhTrC0+gVOkB9njRhqsr
         V7w2TmCFzchAJnRyl1OsWlEI7BjVNdenuqozudi/rpScpMqAziGQTvMvjkdV8+MMKmqH
         wp49EGmK8se7X+c/xKKhgBKeqXZ2IJqwHHvmUoNYWNhvl1w/cF4hUfY2wr7Hzsp7VelB
         yUXg==
X-Gm-Message-State: AOJu0YwCQPf3bZL4CyNIgquTZPlAES5Cl8ykkk7BIN0APaU1D+grXOLM
        NUZFSFyCRIHbjIeoZGcgHb3+Cw==
X-Google-Smtp-Source: AGHT+IGpZAsr0u40LmAFIBnoenyblGAdF/akNAxWhKXagRU0VCl5wBM7zbZS4N4/qh/XZdhvgEwe+w==
X-Received: by 2002:a17:902:a411:b0:1c4:1392:e4b5 with SMTP id p17-20020a170902a41100b001c41392e4b5mr44769plq.21.1698348544473;
        Thu, 26 Oct 2023 12:29:04 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b2da:439d:a713:b670? ([2620:15c:211:201:b2da:439d:a713:b670])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001c736746d33sm36644plg.217.2023.10.26.12.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 12:29:04 -0700 (PDT)
Message-ID: <14ceb63f-1769-4025-ad90-c38112dfec79@google.com>
Date:   Thu, 26 Oct 2023 12:29:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     laurent.pinchart@ideasonboard.com, balbi@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuzhen Wang <shuzhenwang@google.com>
Subject: [PATCH] usb: gadget: uvc: Add missing initialization of ssp config
 descriptor
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the uvc gadget is super speed plus, the corresponding config
descriptor wasn't initialized. As a result, the host will not recognize
the devices when using super speed plus connection.

This patch initializes them to super speed descriptors.

Signed-off-by: Shuzhen Wang <shuzhenwang@google.com>
---
  drivers/usb/gadget/function/f_uvc.c | 14 ++++++++++++--
  1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index faa398109431..786379f1b7b7 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -516,6 +516,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
  	void *mem;
  
  	switch (speed) {
+	case USB_SPEED_SUPER_PLUS:
  	case USB_SPEED_SUPER:
  		uvc_control_desc = uvc->desc.ss_control;
  		uvc_streaming_cls = uvc->desc.ss_streaming;
@@ -564,7 +565,8 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
  		bytes += uvc_interrupt_ep.bLength + uvc_interrupt_cs_ep.bLength;
  		n_desc += 2;
  
-		if (speed == USB_SPEED_SUPER) {
+		if (speed == USB_SPEED_SUPER ||
+		    speed == USB_SPEED_SUPER_PLUS) {
  			bytes += uvc_ss_interrupt_comp.bLength;
  			n_desc += 1;
  		}
@@ -619,7 +621,8 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
  
  	if (uvc->enable_interrupt_ep) {
  		UVC_COPY_DESCRIPTOR(mem, dst, &uvc_interrupt_ep);
-		if (speed == USB_SPEED_SUPER)
+		if (speed == USB_SPEED_SUPER ||
+		    speed == USB_SPEED_SUPER_PLUS)
  			UVC_COPY_DESCRIPTOR(mem, dst, &uvc_ss_interrupt_comp);
  
  		UVC_COPY_DESCRIPTOR(mem, dst, &uvc_interrupt_cs_ep);
@@ -795,6 +798,13 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
  		goto error;
  	}
  
+	f->ssp_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER_PLUS);
+	if (IS_ERR(f->ssp_descriptors)) {
+		ret = PTR_ERR(f->ssp_descriptors);
+		f->ssp_descriptors = NULL;
+		goto error;
+	}
+
  	/* Preallocate control endpoint request. */
  	uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
  	uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);
-- 

