Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4B7D2464
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjJVQVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjJVQVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:21:09 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E210F8;
        Sun, 22 Oct 2023 09:21:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778a20df8c3so182632985a.3;
        Sun, 22 Oct 2023 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991663; x=1698596463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgjSE66tE6JZzaSVNRveIcOcsT4Kj5DPZibrG3bgtDk=;
        b=fMRgLTgDCcKkgPYu+FQMBqi63sEtiqcCOwvRbdL9vkHSvPUtvGgIGomfeVtCCw1ASC
         A8ckRs8LaGbl1OGMGOaLn6HNipC9wwRaJp1kMDh5GwmKByOwZp0AlxB1QiKziEsljs9p
         VcVxtxZf6uukrJAaesAG2ZhuUsn1Y7AV6qOhIFz2jIFefqdiX1CecHCgmKr+ZTqWjOqa
         p64zge+W7VZfOGmykDh3XWh1HBzqkMvgCPuAyS2zxf3OUbUUOsN+DAWNKDVnMAN5uqIR
         YYVpqcwDh8C36f4tB1Y7YvUoyCM2ICUE7J3f0uTZJBZFZFl1Tu+dPv8apZKmKhCiaVGG
         8A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991663; x=1698596463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgjSE66tE6JZzaSVNRveIcOcsT4Kj5DPZibrG3bgtDk=;
        b=LvBnUafB7QqTFlQC29P4X8v7phtRuDAmDCmIlUUKCW+0sCnhzlJVEgDcDb1+s1ZJCi
         D0mke+Itwao7sO0TDXnRfaBOYr5E0/1L83VFmZ6++NASVa4R/Fe/Stf/CNMaDAYiLS2D
         V0SiYTMPsRts6ut+u81c/9ZjXbT9KS7DacceUZRY2+3j5bNva4WeotE0+8XcA4uhkZXq
         fzk96rsn2iEakFJB5ia6rkiELEQdSIgH4zBeVC368JubsVRpwp2ZYMDqdMWEsOerc+4l
         Racwv00E8jEBE7/+uArXKE6r5mrkEQnox3CzAnCInhLntJ2Y/lB+02DJH97iGpOeQjxC
         MfEg==
X-Gm-Message-State: AOJu0YzdjJkrygQyn9RlG/vKFUIAKkGZ61w163b9xR9+JlFPQNilhw6m
        P2OA/kNE9IzGrYCoZ/qxqhoNu2yEZhBDh8U6
X-Google-Smtp-Source: AGHT+IF6sf0pgRs8aF7roOUY/S7wbWoMyZ/ISqtmhLlos7gvoDOZ83B942EJZE46bHs2QtNaevlPsA==
X-Received: by 2002:a05:620a:3710:b0:76e:f638:bcd9 with SMTP id de16-20020a05620a371000b0076ef638bcd9mr8966868qkb.38.1697991663249;
        Sun, 22 Oct 2023 09:21:03 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id e6-20020a05620a208600b007742218dc42sm2094338qka.119.2023.10.22.09.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:21:03 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:21:02 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 11/17] Update occurences of cork to pointer
Message-ID: <b9db0ba9fe244bd0574adba6764c647b08714724.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates an occurence of cork to a pointer in accordance with the
previous patches in the set

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/syncookies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index dc478a0574cb..4354a4decb51 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -450,6 +450,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
 	if (ret)
-		inet_sk(ret)->cork.fl.u.ip4 = fl4;
+		inet_sk(ret)->cork->fl.u.ip4 = fl4;
 out:	return ret;
 }
-- 
2.42.0

