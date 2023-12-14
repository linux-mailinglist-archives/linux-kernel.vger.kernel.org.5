Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC7813309
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573477AbjLNOZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573453AbjLNOZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:25:09 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9151E9C;
        Thu, 14 Dec 2023 06:25:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1e2f34467aso750445066b.2;
        Thu, 14 Dec 2023 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702563914; x=1703168714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=palsx5VIwiV3lVq548jtGUNWQua/RNNKDbImyebYbPE=;
        b=AsJPnZ2rpPZ6UI99MxQUtqXLXf8HIpaSNotSrerGA9FrRo9mNyZRO1aFNaCx2q24W8
         woohfthYgqA07g0HQLGVne6I32eCq4sYmwFslsVglydfepXxiOQXunfTSZlIqV8L6Vut
         P7uAurRl0LxQU+hoLGbY14SWCw3HE+xkiyWGou316X5WmkXT1stWKJN+qj9W5dk84iiy
         MU7jCzlaiu6oi04to7NZ/L5crloiZUTLOliLPLzITXKfWr7Rhsm3pTmY5+fcYF+yb1kT
         nV/+LPArS9Mq7iBLLC/Psc1/+WI3tARmmQOllpUQ32kzRpMUlfM+142cCt81+eLiC6Vx
         oBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563914; x=1703168714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=palsx5VIwiV3lVq548jtGUNWQua/RNNKDbImyebYbPE=;
        b=me9Y+LKRQjnM5+n0oI+uUl5BbEzvBQIqjDvMnRkkqXRv1vqdf9M5SjChjImM2qrSwl
         jiB8JrqVqopUmXW9L6WYu4oIGJq/hMPCjblecIp8+As0nGJA/3YAJTReNuKg/G9/YnMm
         yWww3szcq//IvEFHbTeOA198boLq6tYSRAnCmQHLhhfP+H8ZMYdm1Yy2ALNJO1np+gjl
         8yk7M6FSU/gMA2k6teWreAem0IZJZRBEmDllL3A7nioblpeEVYeNXYxL4UA7UX4mEkUT
         DjwzZg+FME3qB5VKlCK4zEUiqtRZn0OBm6JBa4wR1myt1JlEpTkMHdNI2QfSgTZoPqtC
         EudQ==
X-Gm-Message-State: AOJu0YyELxlT+W9gNbukH6S2x3QWlTJlGBbS73qRexRRApM+KsFoGayk
        oj2Pa7Qad92g0XRMRlYYvN5ZpM/vHPgYLA==
X-Google-Smtp-Source: AGHT+IEK9LX+g/G+1zUGApWd4RjRWxnVcnFClxY6nAZFvzYL5F/Zi1gKClEoHSDV2vUxB9Wf1eFp7w==
X-Received: by 2002:a17:906:29a:b0:a23:f3a:d997 with SMTP id 26-20020a170906029a00b00a230f3ad997mr617781ejf.75.1702563913837;
        Thu, 14 Dec 2023 06:25:13 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id tl1-20020a170907c30100b00a1c8d243cf7sm9409988ejc.2.2023.12.14.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:25:13 -0800 (PST)
Date:   Thu, 14 Dec 2023 16:25:11 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: dont use generic selftest strings for
 custom selftests
Message-ID: <20231214142511.rjbr2a726vlr57v4@skbuf>
References: <20231214142136.17564-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214142136.17564-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 03:21:36PM +0100, Ante Knezic wrote:
> if dsa device supports custom selftests than we should use custom
> selftest strings for ethtool.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---

I didn't notice when the selftest support was added that there is no
implementation in DSA drivers of custom ds->ops->self_test(). Adding
interfaces with no users is frowned upon, precisely because it doesn't
show the big picture.

You must have noticed this because you do have a driver implementation,
so would you mind posting it together with this fix?
