Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF079F8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjINDk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjINDkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:40:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47FF3;
        Wed, 13 Sep 2023 20:40:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3887039d4so4072065ad.1;
        Wed, 13 Sep 2023 20:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694662820; x=1695267620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF11BC+VcMfBsb7nZiDc38LMjNzrZn/Yv7YWmV/x6Ck=;
        b=Vde///wnxRgiWrwNWdR+BwDYpsQecv4z/iZsIOTylE3AyqLaI7mgmLjcfRAjpE4Vat
         JFJDoNKjkw601xyb57vAE7NLcP8Yhx5Ngk3UbBsW8craM/mtQxsnJRIy4w8NSoPUxdZx
         bdRJ0bb0QWcV0DSJpr9ZrwknZAdct+yy4IVFcEj+hmEx8QqHBxnF4fp4yxVS3nJg8Nsg
         mA2JZkSS01+BN3GbKaQtrVhFEq3OYxWmkQQwUl6fXQIK3KMjVfNFegv4dnDEUP9nWHoT
         ynnFqShA0Obs0Htz3ESrlYdCgtkuODeneF/OK9dSbocCz/tFbJYcdkIuvhXVI1WduuJf
         uf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694662820; x=1695267620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VF11BC+VcMfBsb7nZiDc38LMjNzrZn/Yv7YWmV/x6Ck=;
        b=Sm2J9fya9zxrEIlNzLOnuQs5gHUKo4ayaOC4IsPsOYh8KyX+f0fGT0UW5PHj/8chCb
         59cjYNRGoYBTW5JCGGgzoR+TXDIPbg8HDswQWTuXK2yJuzFPHHUas4oJ4NnzuPdhejg7
         CRpTww83I4Ta83XLXRO8WHiAxFw3nagzFRrsU9zZSaaPCp0XIpM2pjPTrImXeAVAJXgs
         mfxzHv1eIcdv18qUZtBlQYFc3yx7SYHtNLYCVPkk6HBc0D9Gt1GrQD33JfJCgRkKIrFq
         wbzBRvDoKRiWRC1zS/39LGiy5kwdGlziYXjQQd2RZq+ponpVrkXNF/tm7DDWS3v0vMuk
         pbuQ==
X-Gm-Message-State: AOJu0YzzstR80jvS5+tJLRtj8VttI8WYgaWdFiTDirP+fiheIKZ7E7a7
        rR5fJZ7LeR9psZC4HgmLtHy9uZcWEdfZthZd
X-Google-Smtp-Source: AGHT+IFERlkcKvpgDAbrnwAmOgDM8XjIT4ksIdsuCCUfBXfw7ZZQe4m2fgNP7WS3eMBHNO7mX6L+JQ==
X-Received: by 2002:a17:903:22c2:b0:1c0:a5c9:e072 with SMTP id y2-20020a17090322c200b001c0a5c9e072mr5087903plg.11.1694662820108;
        Wed, 13 Sep 2023 20:40:20 -0700 (PDT)
Received: from localhost.localdomain (220-133-92-191.hinet-ip.hinet.net. [220.133.92.191])
        by smtp.googlemail.com with ESMTPSA id h14-20020a170902680e00b001b9be3b94d3sm382408plk.140.2023.09.13.20.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 20:40:19 -0700 (PDT)
From:   Zenm Chen <zenmchen@gmail.com>
To:     zenmchen@gmail.com
Cc:     Jes.Sorensen@gmail.com, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com, rtl8821cerfe2@gmail.com
Subject: RE: [PATCH v2] wifi: rtl8xxxu: fix LED control code of RTL8192FU
Date:   Thu, 14 Sep 2023 11:40:15 +0800
Message-ID: <20230914034015.1987-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912112709.22456-1-zenmchen@gmail.com>
References: <20230912112709.22456-1-zenmchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:
>
> I suppose this would not be a brute force if you can use register definitions
> I provided by v1. 
>

Thanks for the help, now I know how to make use of these definations.
