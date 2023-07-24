Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B275EAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGXFfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjGXFfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:35:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E712A;
        Sun, 23 Jul 2023 22:35:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8ad356fe4so23739715ad.2;
        Sun, 23 Jul 2023 22:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176913; x=1690781713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rh0T3l/rmG9WROMZ+kOwJymkH0BdjJef66u+HcPHoVk=;
        b=LFhLXdRYvSVRutAfyxk1bzDphij3TPokm1mNK/9wJ+aOBNlTTsyPXi3GJMfxi1dsQh
         AADbworsmOXbrCl3ctUclN773l8BQtoqSjYVJB0PYzWIxaxsr5NqVz6pzdve3tQXxUBj
         W8H4+38d22NyyO9/m55Xtaf1GLiYctOyNuS5Cgvf9bnkvNsgIrWxUKWL0hs4ZFGpglcO
         oiWnZ1wCe9q30ajp+CPTihhVkWvjdnAS49DFIw8AYhaZm58yPlNpW2dWbYMHEoFGNsZC
         WxWXpMaLR2WP03vJiLfyPh6oUQFJW31j/wYp2fm6Mt2vruayZPnCLFPIES36+8l0XICw
         UK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176913; x=1690781713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh0T3l/rmG9WROMZ+kOwJymkH0BdjJef66u+HcPHoVk=;
        b=Bv89CujlYBVlDVrzpv2M1Xu+HTq/FBuSau7jXVOpVY+wf3GoFO8SdX/jYCaS6Vgz7A
         CCCk0ZxLPvFsMDNAYpoh70T+fwURQx8M0Rm26r7K8FtINZwIS5DZvvbKReUz3fyjXiWS
         lm1gyVtzgf8if0TXpHl5qtqyjPNNjiqUYMf/i2yB1UM0VX2BVlk64Ne5SdbqWkYEqwDm
         JqT8Azj+KIi0a5z3oInBKifC/OQuMrY5C6OCcJGulyffIKqYM5OrJKRQ57+eMttYggAo
         7MV6cRYJQecwbbZ00H7BtWf2sqdllgbKohfkllY3FtimwCeLDmFB5i1GvnqTTWiMhVOf
         Oadw==
X-Gm-Message-State: ABy/qLZrEL+rVNID2TkICXFmX//IfRKVB7nBN5cVobthiYXplEBjLqdq
        dwo4FrKUTTlt+m6biK3cHUHmpCPn//4=
X-Google-Smtp-Source: APBJJlEvHrKDdgwQpzcPq7sWCOtoR/JRCyKiDWlLD4GnLHvY4KRTPiRI+LQc1e+BKilIervi6J/+/w==
X-Received: by 2002:a17:903:248:b0:1bb:20ee:e29e with SMTP id j8-20020a170903024800b001bb20eee29emr10087360plh.1.1690176913148;
        Sun, 23 Jul 2023 22:35:13 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id jg1-20020a17090326c100b001b86f1b5797sm7803391plb.302.2023.07.23.22.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:35:12 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:35:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] Input: qt1070 - convert to use devm_* api
Message-ID: <ZL4NjjNPi+8g6K+0@google.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
 <20230714080611.81302-5-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714080611.81302-5-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 04:06:08PM +0800, Yangtao Li wrote:
> Use devm_* api to simplify code, this makes it unnecessary to explicitly
> release resources.

Applied with minor edits, thank you.

-- 
Dmitry
