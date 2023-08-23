Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36828785259
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjHWIKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjHWIH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:07:59 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63679CD2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:07:55 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso5346238276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692778074; x=1693382874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPq2nAyFlRJ1srV/4l+AURIshuCxxx6kwFTlab2Nnmg=;
        b=NVUKgTgPO4NwPM9jJ428PRMRn1vJATex3IC1eMDV+2CPb7n0SXxEDhmhpS43wCVxpl
         NZXYKEWxpR3WiWL8K+14Xb/iZDz7nf7KWLgrvnakgGwKF8b0vVl38IUccSpB4zN1vQZT
         4kCohnbkjeRSdOOW0v5N5s7rrewsotVO2Pz1KvqOIdcHp/YdgqRWlWbmbUNsU97Raoh7
         AXJiBFO/jZ9tD8seaUkVYt2jFYdwRuK100dP8xbPc1s+lA+qQTsuBlSOSX3uX5Gm8i4o
         SNjXwBaW57C9G0OVNFhIsgo10GFv0y2nTL33w6LIh8yYf0ZCzs/1jGF+X7dgj+EzUMB/
         gQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778074; x=1693382874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPq2nAyFlRJ1srV/4l+AURIshuCxxx6kwFTlab2Nnmg=;
        b=S61w5hBZ1arEccBdD/vb/sjHUPZKFPDfO2dnLqgLxLyFc86XCLoIdS6AKyUDdyNL5H
         yg88KCOnArpYTO7VHOGD8Y1ZCveibfWDYBYzTZ/SQMKVE2VIi79zJrWTM0d9JNYbtWhz
         mrvClboATkeFkLpyruL1NFnbNTu4M1NaqIQhAWZEktaOuJgx0ES+OLAUL6mvS5mhNL4k
         XLICTzKoieEXGFliFXC0IJSVXyMSSHTTffJfkTs+Vij0eSLy8CdDalUuTp2Apjk5RBM2
         Db7HZi7/hi/e+b0FjdrHcsfUKqldbS/OPBQtP7mgf8bZOuZ6LIZLeX6TmZFKLjr9IfAP
         3RdA==
X-Gm-Message-State: AOJu0YxPXJ6KO0nxUzZ82EcFbngWHxWA8RwHwE0oBXP304PuwrI8drdh
        n6qwVSorft7WWpIhoPC/xWWws9/lF9dElNgCNpT8VH3udPWBSEi1
X-Google-Smtp-Source: AGHT+IGZWljuNIUws2ZGsmT+VUv5yJ12xNPPzlLs4IujlI5O6eRv7dkSSb/TxWQPaCdzrQRr3bqkmoOQrQvY6/ZTMjE=
X-Received: by 2002:a25:b8b:0:b0:d4c:bee0:c6dd with SMTP id
 133-20020a250b8b000000b00d4cbee0c6ddmr10895532ybl.18.1692778074590; Wed, 23
 Aug 2023 01:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-virt-to-phys-microblaze-v1-1-e6df710fe0a1@linaro.org>
In-Reply-To: <20230808-virt-to-phys-microblaze-v1-1-e6df710fe0a1@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 10:07:43 +0200
Message-ID: <CACRpkdYG1hhotoUj0o6+o=rFBfgrhKn9QjC2BywZdEmaoOwD-g@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Make virt_to_pfn() a static inline
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 10:40=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> +static inline const void *pfn_to_virt(unsigned long pfn)

I think maybe I should not have put const there. It means the
pointer shouldn't be modified and I think there is code that
does that, or cast to some other pointer which is not const:ed
and then use things like ++ on the resulting type.

If you run into compile warnings you can just delete the const,
or I can send a follow-up patch.

Yours,
Linus Walleij
