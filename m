Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E669A7CB980
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjJQEGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQEGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:06:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D2683
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:06:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3226cc3e324so4918223f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697515566; x=1698120366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRNV9tUzQ0HGiFop7vZJJZrVqaqb06rzYLzB4ERo+tI=;
        b=jb1sqxgWJt96wWrgzgn7xo5jRwXZtmYo3gJgWbKXQg7U51eM7LQmAmO/JHMK7p9rfb
         QuE1RGArWylBksD1uqay+nXqmYRnjdufs3FD1sMER1IppmuTQEQ999Ok56kjgtCVIZqU
         SlZT70y+DoI0BvXu7LzQebrUTO9u5aBY4xDD0i1TitLm7/IrqTLc9KS0Iny9w6W/o0VR
         9RVG6pv92RfA57v4o0k+FYy8jLl7pIF3a6JOJCrw5eo9Z1OlMqD0cWaUxPMUNT8s8j24
         TEc7UCEy/rux2LJoewqaoBbiLtKVfS0XxzwguX2uXcsLluO3BsC3z7v73AoWPjVQdQRh
         6lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697515566; x=1698120366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRNV9tUzQ0HGiFop7vZJJZrVqaqb06rzYLzB4ERo+tI=;
        b=HINLBMAtzW/TwlSLRc1P+uq/JKFU4pnPDng5ctLd0DQx1J3bD/8KByJ1gjBqb9Rfa8
         brObIXMYvesP5ynnJirRMzmcCCxNE5q54VWUP3/+3mylkhAmospMPV9RJx2AAJ0E3u6z
         TcB+0n5TNp6aiI7k5KUyuxI6OWcc81sW4atS30OfIRC2jKh3Its5oba6fkWXWaAY+tgy
         JYZp8xPDmPIaKgQczpArcNnD8Ug6vIOkBI1Y5+65Tfp8+cjMhkkqQZ5AXLso8+o6hAFo
         W6AdRTpK4RFLThxE+CZRTTCGdBoh6jMNet1aJTPskA38H2e8kIFipqmr28PJcsT44aNC
         m9Zg==
X-Gm-Message-State: AOJu0Yx0kgPnu9Kc4RiQcPlKje2q0fyXoo5z1zz6gGQns4rkPW01Jipw
        oKpk+t9FRSC1HSSpOYkBBn4TeWFGIE0hUWMFbJ8=
X-Google-Smtp-Source: AGHT+IEN+tXVbYc7cnEt64cF8i0CMSVyQvciua7ZKHOFgq241fD+U9PdkOH8UFnAr9bcdaxoxzzF+A==
X-Received: by 2002:adf:db0e:0:b0:32d:9b30:9a76 with SMTP id s14-20020adfdb0e000000b0032d9b309a76mr876829wri.47.1697515566203;
        Mon, 16 Oct 2023 21:06:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m19-20020a056000175300b0032da319a27asm692255wrf.9.2023.10.16.21.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 21:06:05 -0700 (PDT)
Date:   Tue, 17 Oct 2023 07:06:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <a45368a0-6f7c-4401-804d-1ff3cb8803b7@kadam.mountain>
References: <20231016201154.GA14625@ubuntu>
 <433b9d45-bb21-49eb-8062-c03bcffa90ff@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433b9d45-bb21-49eb-8062-c03bcffa90ff@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, eventually if we fix enough checkpatch warnings, then eventually we
get to a point where all the remaining warnings are wrong.  Like we've
fixed everything checkpatch gets correct and only wrong things are left.
So just be aware of that, that sometimes everything checkpatch suggests
is wrong.

regards,
dan carpenter

