Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3A7A130C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 03:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjIOBsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 21:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjIOBsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:48:11 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F726B8;
        Thu, 14 Sep 2023 18:48:07 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3aa139a0ab2so957135b6e.2;
        Thu, 14 Sep 2023 18:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694742486; x=1695347286; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0FFekWGyUIP+/QpzRxD5C04IppzIdAo52JFOT6ol0w=;
        b=FE6mzKsEr7W+O8D4CeWuPo/5lhUdydC2rsnIMpgHCNtcS/bwe0XUecvOQnop8HQkR5
         nVWGorokr11TwQchZ8cyueObhL7tl8HtHC0PBUiVjYt/oYJrV4ob980Gb5kIqts+6rUl
         ELgKzKJHi8UnvKy7SS5gTA0POs7R9YFnmwDpp4BMuHANMAudPt4302QqjZgG/rtxzNqy
         ExklNOaBALOGISIxSENIT2STZTaRfJJD8CA3RGBrYfhEpBEHSCRO36nVtvtv4vlCgJWV
         5nTMB10vMAxaeZx1WcbTbgkIKsNmPQsvHXPQnDzhPsiWWfhl9f1L3dKdpcym8GmPrchH
         X7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694742486; x=1695347286;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0FFekWGyUIP+/QpzRxD5C04IppzIdAo52JFOT6ol0w=;
        b=P0zs4AbjNfknUIl6Ad5b9TInkEz0l82rXvVZnc/2GGOniWosDYdkOtkts7f4y2fw/R
         8yK0pkt7Hnt8r9upTzdK+rvUquWijjY7c4ATURbuKncfAY3eSiUhiQXoBvG7IdLMSNuo
         ezGxRuC//18OB/6QdnUu3VdxwEdwi9fc6sJrAdyLXysj92NXoD33vPBoiokixUSNKXAs
         lcCzCjdl+Nel14K7Xi4JeqahhzU7d4p+j1jIZr4DwLLowrGAX2NHnhenbeOovda6n7FF
         8IjdeR0fHCDlHmK1FetIAuHNZEvkYsGuhWBKIPZ0pRGEFi2Tr/Q0USfyDNoKnEwAMkkJ
         2hOg==
X-Gm-Message-State: AOJu0YwJNf8+CuNFW5z2iqG83oXcH/8udDK3uC9xcIn2cD8eGKFPfxeh
        4nxk0uub8zBp+9enpRJn0fM=
X-Google-Smtp-Source: AGHT+IHMBTg3s39w5nzKGtWCSn3FgFj4ijDZgoj1j8XZ4FGFvetP6Mq79S/qKyPMIn9/Up2tlE9QEA==
X-Received: by 2002:aca:2218:0:b0:3a8:5ff0:6b52 with SMTP id b24-20020aca2218000000b003a85ff06b52mr341083oic.15.1694742486434;
        Thu, 14 Sep 2023 18:48:06 -0700 (PDT)
Received: from ?IPv6:2402:7500:5ce:c546:8426:5e14:d5b7:9128? ([2402:7500:5ce:c546:8426:5e14:d5b7:9128])
        by smtp.gmail.com with ESMTPSA id m21-20020aa79015000000b0068a6972ca0esm1905533pfo.106.2023.09.14.18.48.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 18:48:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
From:   He-Jie Shih <bignose1007@gmail.com>
In-Reply-To: <ZQJdnCwf99Glggin@ghost>
Date:   Fri, 15 Sep 2023 09:48:01 +0800
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Reply-To: ZQJdnCwf99Glggin@ghost
Content-Transfer-Encoding: 7bit
Message-Id: <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230914001144.GA924@sol.localdomain> <ZQJdnCwf99Glggin@ghost>
To:     Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: Apple Mail (2.3445.9.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14, 2023, at 09:10, Charlie Jenkins <charlie@rivosinc.com> wrote:

> On Wed, Sep 13, 2023 at 05:11:44PM -0700, Eric Biggers wrote:
>> On Tue, Jul 11, 2023 at 05:37:31PM +0200, Heiko Stuebner wrote:
>> 
>> Hi Heiko!  Are you still working on this patchset?  And which of its
>> prerequisites still haven't been merged upstream?
>> 
>> - Eric
> It is my understanding that Heiko is taking a break from development, I
> don't think he will be working on this soon.

We would like to take over these RISC-V vector crypto implementations.
Our proposed implementations is under reviewing in OpenSSL pr.
And I will check the gluing parts between Linux kernel and OpenSSL.

-Jerry
