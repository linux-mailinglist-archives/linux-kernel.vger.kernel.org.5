Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C947E6AAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjKIMgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKIMgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:36:11 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB3BB4;
        Thu,  9 Nov 2023 04:36:09 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6ce2988d62eso423836a34.1;
        Thu, 09 Nov 2023 04:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699533369; x=1700138169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hmvKxQt/uNJBfR60KY5o7j2krVVjyiERZNcYaN4kaM=;
        b=G4qgdPW7v16dMMrc1AL+w+I0vXx5iWVQdcgJxsBf8iJs4wYwVbLTByehXI5rxwxudq
         BnaiX0ERBU3XJqHI0TVGPOPQDv15C9FfL+jalF8zH69Fe6JoHMOfNp+EJgDUiMNhsJrT
         3415xdPMUf+RsnwY+D655ad6qMJGo72D0alraVUJq0zBQHmBvcplur4dC/xC5fn/CamF
         gWaDFPInxajcv8duu2Mei2ZjZS66RhWYtIaovZT0fpeQy9i2G0EFIJhc4BYE4W1tAw9U
         /p0VwmQcjJW7bNX/Y5czgyYPkf2OsUbJnEyR1vRdFEjl+7S6in2HVwjO/Abh+SBlYDHB
         K8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699533369; x=1700138169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hmvKxQt/uNJBfR60KY5o7j2krVVjyiERZNcYaN4kaM=;
        b=vOKjkvqbU5Ok/IS0hzWikzhWUKW1AfjB/6JxBVMQjdBjjSkt/T9Z8bne22JuWWHCtq
         qTlGdjlWOf41M6PWgDQ+iO62Hbw2qzbJlNWgtZRw2yCRmuBwaV5+2IsGAg7ZjQLWyYCC
         HdvwqpVwAf+CEzcBUjPWuVjELI08a1sr9o7CnGBAEeMKCJNo5Jh1ye+PGkuTMYM+y1WO
         WN92cLUAbk8902jBR1majuJl2Ja/Aw7SKF1uCqENG2a58e26L20KAXYQPjo0zE/1E4lk
         YVpEOMG7Cjq6OXo+KeXQs0x6LLo3h23wrtEQiN24EGF2kxEEXaQXNR2cBPNgvTWyamsW
         9JRA==
X-Gm-Message-State: AOJu0YxeDwqsnLnInolHCB1vSKAea8c8N5jRmSb7ZVBJ5j020uZVkj3Z
        gSwf2c4uYCSobv8xDVH4S/5i0tT5jeI=
X-Google-Smtp-Source: AGHT+IGbPCSZ0oO0sMkuEFaKtAn57MvJ6tpF5KdTWjv5VA5hj5an1Y3HY5hsaViT0A7sFWGG4YiNDQ==
X-Received: by 2002:a9d:6acc:0:b0:6d4:73d3:11b0 with SMTP id m12-20020a9d6acc000000b006d473d311b0mr4986325otq.16.1699533368842;
        Thu, 09 Nov 2023 04:36:08 -0800 (PST)
Received: from rigel (14-203-18-70.tpgi.com.au. [14.203.18.70])
        by smtp.gmail.com with ESMTPSA id z19-20020a63e113000000b005b7e3eddb87sm4638653pgh.61.2023.11.09.04.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:36:08 -0800 (PST)
Date:   Thu, 9 Nov 2023 20:36:03 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     heminhong <heminhong@kylinos.cn>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/gpio: prevent resource leak
Message-ID: <ZUzSM37FWz6sgH9n@rigel>
References: <20231109085419.84948-1-heminhong@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109085419.84948-1-heminhong@kylinos.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 04:54:19PM +0800, heminhong wrote:
> In the main() function, the open() function is used to open the file.
> When the file is successfully opened, fd is used to interact with the file,
> but the fd is not closed, it will cause resource leak.
>

All open files are automatically closed when a process exits.
That includes both those returned by open() and by the GPIO ioctls.
So explicitly closing them here before exiting is redundant.

Cheers,
Kent.
