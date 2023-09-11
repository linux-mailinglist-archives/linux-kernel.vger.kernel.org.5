Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B306C79A0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjIKAqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjIKAqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:46:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5920D9;
        Sun, 10 Sep 2023 17:46:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bdbf10333bso31986815ad.1;
        Sun, 10 Sep 2023 17:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694393190; x=1694997990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNC3iO34R8W9MONsZ2q/3XRN471AayEfOSPYXRzgL+U=;
        b=EwtIKtUA5UOC0mdcIc1fSSzMZN0nXFGLqtoxRCL4IKhBsfe2LooLajvBABqeFP30iC
         mWf8PRkypyt0tpzfeXWWVLkswyd8xHNXWuEyaPzw4drEFBv7yILfs+oIgmRpxzPCCQ8S
         M4SwO6cNLefhb+nw996o93+xnPTspwcCcv5NoAtrdMtIV6LFoBrzGZ++zOa+XUOYZ4Ts
         YawcVnpmSdXV5Qx3Whp+yYs8gAYDcCkmS7QkPyl9OGc9WrGnky7YaGWB9DsIK4p+NJeX
         HnNZu0CshL/uoE3tsYahn5/8VNyLXjOvJUF+Xe4wPM7Hpg7zDq0QjdSTzDHePP5IXCuK
         ATvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694393190; x=1694997990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNC3iO34R8W9MONsZ2q/3XRN471AayEfOSPYXRzgL+U=;
        b=DFYFXKp3u1Z2l+UB5xOg7wT9sa7VhPVC31/CCcYwMV9ob4Z5MBZF42GyOx9IdI+RZh
         Ehvn7U6EG5npVasn1qTBVDT12mQZiIc2kRuRNMwETSuaDbgLsvOohnvi8BDuvDuLl0/p
         MoeG5wj58a+VAfo4AwNsp2Meu5/VYfJ9ARhDJayrmjGIzeFpQY/v/nTgSjGyWffe9UCf
         imZhjhxCGZ1JGdEZcAATC0D9OQmU3reAtbgE1aCM1ZzGPnVsDUWGU+XRM3ZJ7vwRBv4d
         oS5rrK4UkMWHqrOuCZAIm7lTZfHRy68e08VIgFRVtv+JyozHXUru/pMPACvhcXZlCN9p
         WAJw==
X-Gm-Message-State: AOJu0YylqvQODHj9Kq9PEWzoZKGFnONJWKaa28Fu8MXY6aJvJGdHucLw
        53lGeg6eM/VxhG1t5KKb7lI=
X-Google-Smtp-Source: AGHT+IEAJXPl7ddD9w8uIr3+HH1N/PXN2vXp20paGG1PRgFexc9VSLD44M7opDCW8eNFlk7Z7g39gA==
X-Received: by 2002:a17:902:ce92:b0:1c3:a215:a9ba with SMTP id f18-20020a170902ce9200b001c3a215a9bamr5146478plg.33.1694393190246;
        Sun, 10 Sep 2023 17:46:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090276cc00b001bc68602e54sm5097410plt.142.2023.09.10.17.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 17:46:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 10 Sep 2023 17:46:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 1/2] hwmon: tmp513: Add max_channels variable to
 struct tmp51x_data
Message-ID: <85a8d9a6-712b-4fd8-a2bd-0c30ea9cd670@roeck-us.net>
References: <20230907071404.24334-1-biju.das.jz@bp.renesas.com>
 <20230907071404.24334-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907071404.24334-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:14:03AM +0100, Biju Das wrote:
> The tmp512 chip has 3 channels whereas tmp513 has 4 channels. Avoid
> using tmp51x_ids for this HW difference by replacing OF/ID table
> data with maximum channels supported by the device.
> 
> Replace id->max_channels variable from struct tmp51x_data and drop the
> macros TMP51{2,3}_TEMP_CONFIG_DEFAULT as it can be derived from the macro
> TMP51X_TEMP_CONFIG_DEFAULT and update the logic in tmp51x_is_visible(),
> tmp51x_read_properties() and tmp51x_init() using max_channels.
> 
> While at it, drop enum tmp51x_ids as there is no user and remove
> trailing comma in the terminator entry for OF table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied.

Thanks,
Guenter
