Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9CB77BA64
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjHNNmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHNNmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:42:23 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B829E77;
        Mon, 14 Aug 2023 06:42:22 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7910620f45dso170153339f.1;
        Mon, 14 Aug 2023 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692020542; x=1692625342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQ1BndEZyh9hlN43OW+yqR+mZvlRf7wwEDKyuXaEzhg=;
        b=gIPzX+TRpRjdS60xJEHwINXxk25QVdcI5exN3ClbVTbJuOsG3T3bzDz+F5+7xKfYhy
         RoN4PR/+mib5Ezx0jQuLLPLoKFMEm8qzt0YR+kKPVrqWxnpYIDHgO3T3XFpjlN7U0CZP
         K1fQ+wtTkfaWtenzem7nkqoS0niMMk5es9HlqKYFUHF8QTBWbZRMwWLMGXj7zzA4ul4S
         QBkQ61UeWbPwh8P4ltPLocd4rmz7HnvJ9vDgKZvof5wxQfXkQTFd3P8Pnp4Cmi8PeDeu
         0hG9bEDiIe6EIsp3Bpu+VhnzqMxKGl0HSBu8HeY1xBQOmvDp2far2U8h9aslJJD3Yu1C
         SGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692020542; x=1692625342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQ1BndEZyh9hlN43OW+yqR+mZvlRf7wwEDKyuXaEzhg=;
        b=RqsfxNpAGsTjcr/L5UVeUQNrPJzXZcinqBIkWlB7Tdnah6lKd4eTXXg6DNFHmY1/lr
         N31uRj2zig8JIb1HXHYYqBsRXB+w4IAJL6VYLd8613Jad7sjL6R3ZkC/CKc6eWL3aL+S
         ryfMIOQCrvjCgXynnH78W/nhVy/9+4I//QGeA0VZ4si/4N5jozv8GezThtXlIAYf/16T
         rq8hp8HGINF0mLCb8YQB9z9Qq9muDSOO68dRcuRLOBEvZv++wnfN9L6QV4Sg9Px9EU8+
         s5QuMtI8v3E4eFfrbjn7f8XW8siaaQNvWfcYCeNY/JKvdyJ/UMIfIirOw3P0MmxI60QQ
         6xZQ==
X-Gm-Message-State: AOJu0YwzwwDntNWzLRxAJmBFU+53pEGa4Ur6VRNRHPsOWflQ4JpnUOTK
        0vcjDzNYFy0j/VrxCYCvXx64XR3JOWI=
X-Google-Smtp-Source: AGHT+IFnsYuB2Rf1MhBU1dOF3WXA0tBbTdK33QOu/mG8IrpH/8p8OwSXe17qEzZwv0eKHRU6Fsgkew==
X-Received: by 2002:a6b:4908:0:b0:791:280:839e with SMTP id u8-20020a6b4908000000b007910280839emr11879345iob.16.1692020541810;
        Mon, 14 Aug 2023 06:42:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ep3-20020a0566384e0300b0042b451aa95esm2905409jab.150.2023.08.14.06.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:42:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 06:42:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (aquacomputer_d5next) Add selective 200ms
 delay after sending ctrl report
Message-ID: <b1083bf1-9d28-48f3-a984-38f63ec1fd16@roeck-us.net>
References: <20230807172004.456968-1-savicaleksa83@gmail.com>
 <c151d464-da26-4c53-ba7a-d16bb8fca949@roeck-us.net>
 <e7bcf401-991c-808c-66df-65664940bf22@gmail.com>
 <0d94544e-59d7-1860-2cc4-1a9130023b2f@roeck-us.net>
 <932973d5-812b-8bf4-26f0-d167f51f997d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932973d5-812b-8bf4-26f0-d167f51f997d@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 08:49:49PM +0200, Aleksa Savic wrote:
> On 2023-08-12 01:05:19 GMT+02:00, Guenter Roeck wrote:
> > 
> > It has a Fixes: tag, so it will be applied to affected stable releases
> > automatically, at least if it applies cleanly. I could have added Cc:
> > stable@ to make it explicit, but I had pushed it already, and I didn't
> > want to rebase the branch just for that.
> > 
> > Guenter
> > 
> 
> Didn't know explicit Cc wasn't necessary, thanks.
> 

Preferred but not necessary. You should have received an e-mail telling
you that the patch did not apply to 6.1.y. If you want it applied there,
send a backport to stable@ with a subject such as [PATCH v6.1] ...
and backport comments after "---".

Guenter
