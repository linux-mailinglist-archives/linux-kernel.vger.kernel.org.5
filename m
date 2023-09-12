Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3593979D9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjILTtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjILTtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:49:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBA0115;
        Tue, 12 Sep 2023 12:49:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fac346f6aso2900903b3a.3;
        Tue, 12 Sep 2023 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694548153; x=1695152953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXtz6kUeyzBvqA0abDYiD1qX4EoG1vT0PHAg7mdRrOA=;
        b=ZkIjeaK9JRohqDKx4Giz8HfnViZA77fnbPa/0vMstQRFCLiEIkXapYSq6OGBe2gxMZ
         TNTyBZkKsVfcA/FL0ramwXH/G23OmyyPcCgHLGZvXPC9Qipxsq992iyDdWQoJErfVAiz
         ZreU62S/RxBYPO4R1llfh8HJFHdEcXnP4Hb0mCzSbnhbKM8AvLkKWaXbBRObtPf4M50Q
         KDs6+VP9/awigQ4wR5raKdfdQFuaEanmJIUTELUtQEgC0a6RCbTDB/eCW6yD2f+9Gjim
         WeGIbwKft+8ha6joSEAYMQoxyNQtTqlOU8HVWZjHtPLC6rjlcO/J4c6roPKu/2fd3sTR
         Yu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694548153; x=1695152953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXtz6kUeyzBvqA0abDYiD1qX4EoG1vT0PHAg7mdRrOA=;
        b=g+M2rAJcds2EnoA9v0REv0QyehBNA/h2bl+ho33+9J0HyJyfhRQgSoSJXo0LJ7NGO9
         q0nzJSqqjlH9n/ANOlQHu6e0dPoVayO0Z1ZVmO4aiXjoxO3Kdp7bLYlZ2cG0sQZUkjHs
         TFJZF5F86QTdjGT1UKymIB8I5mMyk/HKawYKZ5GQqH6WC1LNMz3Bva41YIrRrsUiqO0x
         fW4haHtHw0vj2vO6nD4zqLSa81mtvmfOc/EN5zKIo68xnuzJ764wGjHBbJ8QPwk1eznf
         fin3UwoHdjElf4G6o6ULzpfQsZ0O90ngsMYb8eFKPogd9TlBY8BcIGBowqVSEU+DDR4M
         vS9A==
X-Gm-Message-State: AOJu0YyoNwnk2EL4KC7fffx3NzznMGvz9ig75Pmgul0vwqQgQSWBee3S
        SP17KCLZKmZjL0k002Wf9dM=
X-Google-Smtp-Source: AGHT+IGQGAAlkxVcbXgpeRdjUlyV5lOAHgZaQ4fT2dRzL337/7ncDt/qjvZswUeNAvL7v0AnlIEDWA==
X-Received: by 2002:a05:6a00:248a:b0:68c:dcc:3578 with SMTP id c10-20020a056a00248a00b0068c0dcc3578mr832412pfv.25.1694548152785;
        Tue, 12 Sep 2023 12:49:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b006829969e3b0sm7713640pfn.85.2023.09.12.12.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:49:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Sep 2023 12:49:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
Message-ID: <9becc541-29f1-42ea-8b7c-af5f64d8bcf5@roeck-us.net>
References: <20230911134650.286315610@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:37:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
