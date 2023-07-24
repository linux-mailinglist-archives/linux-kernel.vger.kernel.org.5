Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73AC75EAE2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGXFdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXFdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:33:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3540109;
        Sun, 23 Jul 2023 22:33:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b9cdef8619so23934755ad.0;
        Sun, 23 Jul 2023 22:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176814; x=1690781614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVn35CE6nwhyaJG+wyNKRSLb+rPK3wiLlrRkYL5+OdM=;
        b=rVyXzKymg6f1dY3aIRBnv3PHnL1cn+yzYMWVPf0eH21YoeYnYsQe2K/mBHOhV2TRtb
         51TZ/jZMi6x9liGCMkANG0u9dZQDm5HdmTisW8gGCjS+S9ezA552Nlmf3e1iEDqWmnAP
         i0I+KyOIRPA4lLlpL5/99rG8igD1TLvnxl5hYkW0BY8xqXk9tJSUlWbMeul/aiXw2ozn
         jg7BNrAisK1C4MXf3zpyIU+TzugbMaMtjvRqB2jOgb6/ivGS1sBMBoVGGKewgNVzowvy
         MNKxTPNj2ht+oBMammWRkIowWD2RHFBMX93CxWTWUMTeR9nTmYamoeOw984QnKS5b0rt
         hGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176814; x=1690781614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVn35CE6nwhyaJG+wyNKRSLb+rPK3wiLlrRkYL5+OdM=;
        b=M0pA85uM1zRtIOoZusJosrzEHW8GjAEhDut0Kt3X2yMjp2o66VlhL5q0RdA0TARdR+
         iMYU6GBXUMavDHtfP9NBIQpfCZvwiXz8h1+HDaxLLGxBcJE6PmVfxeV6IdP2dI1IYY6S
         dvD4MWatAw2pDop4zBf4cQPX3V33Bqjfxk+Hfi2x+cBr/Nc5dJ4Q9l8bM5q0uGrj7G3F
         9T6pxAmMn/D7jo9T1sG6Vs62HqvkBQDTX0JBIkbHac9lvfGDDhcVHHsZ6VNYEB7gYXvu
         ZD5zmg5B+u2W0QL5EX03i+E9mYZDC/J5qVYbG4B6hdNNnjQY5N2RE5OjKjgtuhTXGgM7
         DNVQ==
X-Gm-Message-State: ABy/qLZOYWPssNGruHMUL8lxyTBpWTFrwdGRzO9gImJdPRkMeZHP9yna
        hgYJSN/YNPdP8O09kxGRGkvq6phyxsk=
X-Google-Smtp-Source: APBJJlForkDUKfuv0ncQ0s8ysJpAnUtZtJiGyA9kYJjwe48iwatepWwiJ9UFoyH4HMCxkfqnsk+nOA==
X-Received: by 2002:a17:903:2309:b0:1b8:ae8c:7bfb with SMTP id d9-20020a170903230900b001b8ae8c7bfbmr10126749plh.17.1690176814186;
        Sun, 23 Jul 2023 22:33:34 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001b8528da516sm7859587plw.116.2023.07.23.22.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:33:33 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:33:31 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] Input: amikbd - convert to use devm_* api
Message-ID: <ZL4NK/I6MxiFJAi6@google.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
 <20230714080611.81302-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714080611.81302-2-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 04:06:05PM +0800, Yangtao Li wrote:
> Use devm_* api to simplify code, this makes it unnecessary to explicitly
> release resources.

Applied with minor changes, thank you.

-- 
Dmitry
