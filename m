Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610B77CEB44
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjJRW3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJRW3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:29:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9020D115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:29:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c0ecb9a075so51297775ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697668158; x=1698272958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlEhPotc9YVtJuw6c5D3IvfNe+8QoING9f1FrC2gg/U=;
        b=JT3ODgYecULnjYpL8MERlDIjflhc1CPn9eeq2YXXsPQID82x6RcvoccyBhciNM/qt0
         KBaQivWvSMJ/5rYdwMHBuIiQDdqNZyPnIP/vYt9qKmwwfH/8CAlJNw7r3R+1XtDqI+Cy
         Gj4Gl+bU+jQI8wDOkfVlSM2uoLG/O1p+4Uacs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668158; x=1698272958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlEhPotc9YVtJuw6c5D3IvfNe+8QoING9f1FrC2gg/U=;
        b=duZ2JDxMUlXU5isj3xcsICUiCmD64yYQ+2H6WlSpx+aRESugB8Vc5xVrbbzqoZ9Csh
         vctcdXLdQTiQRte9q4Ll+XV/iUTTTe5G/EUd6esJ6zX1oD5cyWYJcus1tO1FkxrdPdeZ
         YD7iNPpTFvuZyOuv+Wz9+JerkCljzn+YRQ9AZmqfwu/Exl7rvnTUGQ5dE/VJy5nRwTU5
         b2PtV+K3oiAjFCGlZrS3DlPZ0sE+oJBCBvd750j7JbkPXU79dNP0OFDIpmJ77d7Vc7jR
         jg37tvMjd7nddgAr1tfGeqqA8EPQdBUXBqntu6F8XThcqnceGpR3J8ajG+3465Fe8Gsn
         T9Sg==
X-Gm-Message-State: AOJu0YyALSbHrqFh4+gb3xOQv44IYs2NNpidHkYzxDQHs+mkEVpq3+cu
        KTDdP3VhI3GuVbssz8O7tmBt1Q==
X-Google-Smtp-Source: AGHT+IFa7ai3cfHBIJet4SvOmgqTNI6nHVqvudThEcy1ldRSisV/7jAkhiE1Axsq53XFBLKli+nTAA==
X-Received: by 2002:a17:902:dac8:b0:1ca:64f:35ff with SMTP id q8-20020a170902dac800b001ca064f35ffmr877478plx.48.1697668158080;
        Wed, 18 Oct 2023 15:29:18 -0700 (PDT)
Received: from chromium.org (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001bf6ea340a9sm425908plg.159.2023.10.18.15.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:29:17 -0700 (PDT)
Date:   Wed, 18 Oct 2023 22:29:16 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     RD Babiera <rdbabiera@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: altmodes/displayport: verify compatible
 source/sink role combination
Message-ID: <ZTBcPEXV5UL_HP3W@chromium.org>
References: <20231018203408.202845-2-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018203408.202845-2-rdbabiera@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi RD,

On Oct 18 20:34, RD Babiera wrote:
> DisplayPort Alt Mode CTS test 10.3.8 states that both sides of the
> connection shall be compatible with one another such that the connection
> is not Source to Source or Sink to Sink.
> 
> The DisplayPort driver currently checks for a compatible pin configuration
> that resolves into a source and sink combination. The CTS test is designed
> to send a Discover Modes message that has a compatible pin configuration
> but advertises the same port capability as the device; the current check
> fails this.
> 
> Verify that the port and port partner resolve into a valid source and sink
> combination before checking for a compatible pin configuration.
> 
> ---
> Changes since v1:
> * Fixed styling errors
> * Added DP_CAP_IS_UFP_D and DP_CAP_IS_DFP_D as macros to typec_dp.h
> ---
> 

FWIW,
Reviewed-by: Prashant Malani <pmalani@chromium.org>

> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

BR,

-Prashant
