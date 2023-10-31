Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946527DCAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbjJaK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343640AbjJaK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:28:06 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F1083
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:28:04 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c504a5e1deso77571941fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698748082; x=1699352882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaagOn8jPXjQl6PIIuGW+mOnt3BUe6CBcTW08fMQBa0=;
        b=kDHJ+q/trVvOBZI98oUIk8qZKb1cgQGh8LXX2XOGl4BgNP56h+wEtDV8jiaDJZ2Cwk
         P7/oZde/F5nkSzt3aY0iBNBNHSKjRZ/SIeFCvLwwtBBhQWlnajDnOBD47CmrgHitwvZn
         OYvz5MYXDXHE3jsztMI/WZJczlIQYbel6P+1xAU4M4241X0OgkGb5IkH82z6F7UEnSSo
         LIIgV8m/i+ICBWwYp/b2J5RRo2sWmmj0PSGNNwnWWXM/CUpiO74iOsEwQldFXNQhJx/r
         xsRVxRoqvWYyHMqgjYzRshbdzaJHY9nPCU5EH6MKISuVt7TdL8wfP6pGfQ5khkFlzBuY
         INrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698748082; x=1699352882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaagOn8jPXjQl6PIIuGW+mOnt3BUe6CBcTW08fMQBa0=;
        b=o7ZGuAFodqEO1lvC1LQOagtTt35yAX65Y2pmEuctLV5MfmumORPchtNBMuRJALz9zW
         9Bc9hH4YGgUwtfMjeMCCtwBgyhobeJjO1AJ50z/YNdUV1O0G7WTO5yVq1fwewMjcST1K
         HEZc9ZdO3L3wR1zQboqndCmCyO/4QI9WHWcH6ad7uR3ybtxmxvNMxykfwfiCDKTPCMgS
         YYaJtX6obNdf50hBLKgyM4EDHVsWe0ytHzkxum6SnlASydBa/KlLC+QJsn1w22FBaBVf
         rZ1YTcbpsDeUcRjnhyegUm9kKYd97puMEixpTonb/zMj4loa1yivE1nFlr/dqI/pmPd9
         K4gw==
X-Gm-Message-State: AOJu0YyAzYxG2E3XtfN/G42FQFXl+TxvN2kdCbUxniPtjnmyBhPOvshD
        5HPgofYyPrYHy1RjjRZJWOKj+w==
X-Google-Smtp-Source: AGHT+IFMWkwmSW5SOzELVmhfggUt0jYW3qNZpAyrcPZw7EFRT9Ua080roa8h6HCZMYw5HqzBC4vqBg==
X-Received: by 2002:a2e:494a:0:b0:2c5:1a89:41c0 with SMTP id b10-20020a2e494a000000b002c51a8941c0mr8374240ljd.23.1698748082529;
        Tue, 31 Oct 2023 03:28:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c485400b004063cd8105csm1323646wmo.22.2023.10.31.03.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 03:28:02 -0700 (PDT)
Date:   Tue, 31 Oct 2023 13:27:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Rohit Chavan <roheetchavan@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Added blank line after declarations
Message-ID: <d94519dc-8e2e-427b-9828-4f714d0561a1@kadam.mountain>
References: <20231031100610.5394-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031100610.5394-1-roheetchavan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:06:10AM +0000, Rohit Chavan wrote:
> Fixes below warning reported by checkpatch.
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>

This is a checkpatch false positive.  (It's not "after declarations").
Just ignore it.

regards,
dan carpenter

