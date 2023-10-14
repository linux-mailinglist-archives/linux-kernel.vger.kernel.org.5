Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4A7C925E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 05:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjJNDDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 23:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJNDDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 23:03:46 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EBBBF;
        Fri, 13 Oct 2023 20:03:45 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2bd27f203so83557b6e.3;
        Fri, 13 Oct 2023 20:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697252624; x=1697857424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ41a+RB4Qcm7rS/XEuMa2q8TcH82epeacH0wtL3/8E=;
        b=TYlvQymoO07ENRA7PXMwNyo1tkE6nWTgWc/VVEQThBy3y+ztGIaO+y1gh6bFazSw87
         olSRLGoK+GUYZ8awURVf0yyFMqdD3RricuTuNkIGS1ODRswn79JkSjDFExBlfWE5APGR
         kQocaO9rHMnIk5nJZELhd5AoN9Dct4FfF8OFv2EhYk+O/PBheYevrDtfc6FPkUxaQ7N5
         flv6LSFiIpWc8lNQK80Ue7FMLz4oElIdSQj98jQZfU7lsS54Uvk1IrJQN4kspxUMyW9w
         R2EmlsX41PozjLSTJUasV0sYmZ/ApNqr99AJNGyeMK7M3I4DHfa/cdZrAobsGdRNRWZB
         xnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697252624; x=1697857424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ41a+RB4Qcm7rS/XEuMa2q8TcH82epeacH0wtL3/8E=;
        b=gUWnaYDrcN9P7OggJZViJkwv2Fx+rWMKWp9cCnO2UAycYYrtte3lcvEKQhh3S0M7rI
         UmneS4tFkTQDs8qfYazv0GdmWKWpYq+tt0AvNEKaCf893xgOZsMUJ0fUR7JLzhnqNcuA
         td1MGT3VxbzNwTwUMql7Dxcokcv3mXdvZnKt0OldPeeYPIA59mig58oQnH8jfh7qAfhi
         SAcJdIDrPfuTl78fkgPgAWHwjjjZ0Tc5zGlDjn6mToV5MbRknFy7aiL+eiCSBp5GfVnR
         mh10bdGR+m54/66BbWDIZJkVQtUohlpVDG7eKAIcxyf949tmgmrmuDm9AP0kJ2MnuFeO
         liMg==
X-Gm-Message-State: AOJu0YxBZrvwlU0lFBXjHiv6XXAHh4yVWbQbvOxQ7wxtLHYuXfrcvprf
        rdNBXBg3gecKSXtyEMUGwuQ=
X-Google-Smtp-Source: AGHT+IEdMMcUV3So6+0HELJUoYR3j9NRzFHv3hhzcEMkDjVT4n7uyiM8sepNeVagyVxSIDwQEAHreQ==
X-Received: by 2002:a05:6808:1146:b0:3a4:316c:8eeb with SMTP id u6-20020a056808114600b003a4316c8eebmr44717767oiu.40.1697252624151;
        Fri, 13 Oct 2023 20:03:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:469c:3411:2771:1b7f])
        by smtp.gmail.com with ESMTPSA id hg20-20020a17090b301400b002776350b50dsm780310pjb.29.2023.10.13.20.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 20:03:43 -0700 (PDT)
Date:   Fri, 13 Oct 2023 20:03:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     John Horan <knasher@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Input: bcm5974 - check endpoint type before starting
 traffic
Message-ID: <ZSoFDLv8_CG1SGN6@google.com>
References: <20231007-topic-bcm5974_bulk-v2-1-021131c83efb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007-topic-bcm5974_bulk-v2-1-021131c83efb@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Thu, Oct 12, 2023 at 06:51:49PM +0200, Javier Carrasco wrote:
>  
> +static bool bcm5974_ep_is_int_in(struct usb_host_interface *iface, int addr)
> +{
> +	struct usb_endpoint_descriptor *endpoint;
> +	int i;
> +
> +	for (i = 0; i < iface->desc.bNumEndpoints; i++) {
> +		endpoint = &iface->endpoint[i].desc;
> +		if (endpoint->bEndpointAddress == addr) {
> +			if (usb_endpoint_is_int_in(endpoint))
> +				return true;
> +		}
> +	}
> +	return false;
> +}

This essentially reimplements usb_find_endpoint() in a sense, so can we
instead do:

	ep = usb_find_endpoint(iface, addr);
	if (!ep || !usb_endpoint_is_int_in(ep)) {
		dev_err(...);
		return ...;
	}


Also it looks like the handling of button endpoint is interleaved with
the trackpad endpoint, I wonder if it would not be better if we have a
separate "if (cfg->tp_type == TYPE1)" where we would do the check,
allocate URB, and did all the rest of set up for button transfers.

Thanks.

-- 
Dmitry
