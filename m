Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B607D9C80
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbjJ0PFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjJ0PFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:05:14 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0C7C4;
        Fri, 27 Oct 2023 08:05:12 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a81ab75f21so16053987b3.2;
        Fri, 27 Oct 2023 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698419111; x=1699023911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQu0HXWxg/bw+Vw+FrohhEC9fLwx72NjkBypqaswEkY=;
        b=UxUdmor53pwyLAsskbK2CkP2geY1Zz3wynRa3+MJ3MBtEpwhOvhQsCkZ/xXaUh4O+n
         SKUwXEQnZypSqeJz6gmihU8wFM/H5GKNo8dDygRbpz7YNFLKce2cagWWWAcAdFhh9ngA
         2imyZjuKFjZbKLyTKB8p2efdOd0qY6A6mPDyELBIurowCD/ARNssvnxRJkunMSHovUBL
         MWqsuiAiHOUJa4WaIt1GX2DGq2u0oNs0b2pj9s3VF7+FJl2UF7v4gU9Mz/1+L+Sa/kFI
         N85ACkhcVQ6SrMZ5t6E+Xnh6VV1XgMe0euI4I7Icr+Dxacfh6XjkOHMWttQEoiwT2Jru
         jdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698419111; x=1699023911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQu0HXWxg/bw+Vw+FrohhEC9fLwx72NjkBypqaswEkY=;
        b=LxfYWxzm+FQt4rn4XLGs3M8BbenmIYuG9rq45nXyHrWD8kvHqUXvOORIKStWEu4GSc
         a6mgOK7oK/AO1D8oszwtDY1cNMUq9Ibu1rEnB6zKs+vJiGiHCPK1irY1fFqNeSCUW1oI
         eOqHEXEc3NTNHuOm+635UwykAJc99KK6k0ZPpy0SyinaC4AfC/19kbcu7GMM9BrdmABD
         uZG9ej2NsyosCDHJyJdp6qiDotJ6sP1hio6Y/eX7iVUASMU+uDol+jDl1NVKXh6nym5N
         LEMuiZMI+Axd4pNgwH62hUGj2ueZfd/+6C/0vLJisZvIijokVH/SPae0YEYcMHaYyOvU
         Cx8Q==
X-Gm-Message-State: AOJu0YxNfjUd3u5BQxKcKfZ5RberQaSP7lsvlrTBJ2dgnKZz4qY3AP7Q
        x9hDFsAlW91sEUzvtm9CIm8=
X-Google-Smtp-Source: AGHT+IF0GB7buGlBHwGw0965jzDFvObGEBGKMJGLFIgNKLAyyYMQAGvRP2DDVO4ngTvyYhNTUmKObQ==
X-Received: by 2002:a81:af61:0:b0:5a7:be23:6a7c with SMTP id x33-20020a81af61000000b005a7be236a7cmr3206097ywj.6.1698419111104;
        Fri, 27 Oct 2023 08:05:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bz4-20020a05690c084400b005a7be2919a1sm760232ywb.14.2023.10.27.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:05:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Oct 2023 08:05:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] hwmon: (pmbus/max31785) Add delay between bus accesses
Message-ID: <629a994a-6047-4989-8b22-c36fa7167d10@roeck-us.net>
References: <20231027044346.2167548-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027044346.2167548-1-lakshmiy@us.ibm.com>
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

On Thu, Oct 26, 2023 at 11:43:46PM -0500, Lakshmi Yadlapati wrote:
> The MAX31785 has shown erratic behaviour across multiple system
> designs, unexpectedly clock stretching and NAKing transactions.
> 
> Experimentation shows that this seems to be triggered by a register access
> directly back to back with a previous register write. Experimentation also
> shows that inserting a small delay after register writes makes the issue go
> away.
> 
> Use a similar solution to what the max15301 driver does to solve the same
> problem. Create a custom set of bus read and write functions that make sure
> that the delay is added.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
[ ... ]
> +	if (delta < MAX31785_WAIT_DELAY_US)
> +		usleep_range(MAX31785_WAIT_DELAY_US - delta,
> +			     MAX31785_WAIT_DELAY_US);

This means the driver will now wait up to 250 uS even if it only
has to wait for 1 uS. But I really don't want to wait or argue further,
so I just applied the patch as-is.

Guenter
