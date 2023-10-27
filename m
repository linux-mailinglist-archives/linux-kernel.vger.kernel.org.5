Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4553B7DA185
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjJ0T71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0T70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:59:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CECE128;
        Fri, 27 Oct 2023 12:59:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc20df5187so7285835ad.0;
        Fri, 27 Oct 2023 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698436764; x=1699041564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KneZwXZt1ATJDMlMDwMn/YFujpabk3NR7EB4uunod74=;
        b=B+NgXBE/UmFtoz4OvrDZss41bcj2WoCGNmlgSOgxP6Q+z4pH8azQChIewagNTE/aZ4
         mOkK3hVkLTs/LbaqX3TrKFkg6NW1KgYgu9za2Ea01Bb8U2+5PdWswptzlp+YnkwK8Zhb
         AriB6la7TcDcyiVUZe3hietzugL/Zl1oaGOfqEZS1+eYd1PWDovJ9ZqOwYlloeEcb51C
         KmpcXPvp15EWUKUW6mVQh2Vzpri2VaoegA7CrFFz4ByMm6PpJ6LBHk89K4t+AU5rOzIP
         iN/1eg7rxhb37K//Rv/DyGOS3g+8RdRFiEnc62W1rBkwSgkCQP8MPx5yuQyJX2auVqTK
         gz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698436764; x=1699041564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KneZwXZt1ATJDMlMDwMn/YFujpabk3NR7EB4uunod74=;
        b=QylHKgwzF+ZD50fEYIhJoWePHg2f7GYzBhO//1m3R3MCbjji7fdj7Sz0bDxE++hS99
         Xxwnl9105XKNxmpP1qEkZb3qp59yqJtR4T/8fhxxFr3HFyp4QcjZ4mZfxd/tepsvePZO
         0l55hFiu/4WKr2kmeme86NROmW0SjDh8IKH/KG3aJQ2dmb4cJO8ULuBfmzXbYPzTekYZ
         ngUO0IS86iERm5LnHjtLwtlXHpS9bquy40kLbceKTUI2LAmranHTVVrZFYWZ/Nk1C4sU
         Dml1OWOYCvWdhYmsTg6cLtaoHOIKIqE+7JrR6zE+NwVAmWFxS4MAcgHC/8RY4qPuPTMa
         3C6A==
X-Gm-Message-State: AOJu0Yw/AD1Idv5Y82Bzbygb9l5kAL48+EpltCEuGVpd3DoxOh9DsLgh
        Sti2Wx7y+YbzpQR/bcjn6UZkkZ2fkv8=
X-Google-Smtp-Source: AGHT+IFo0y5Al+JDNfDqCXxuxLhLKJ6V+7P4wfn6c2nvaewvIYzr5MS4TlaLXVEwyscLe93hrMccdg==
X-Received: by 2002:a17:902:ce82:b0:1ca:c490:8548 with SMTP id f2-20020a170902ce8200b001cac4908548mr8575592plg.19.1698436763851;
        Fri, 27 Oct 2023 12:59:23 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:449:1f46:6e0d:893])
        by smtp.gmail.com with ESMTPSA id z13-20020a1709027e8d00b001c5f77e23a8sm1995430pla.73.2023.10.27.12.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:59:23 -0700 (PDT)
Date:   Fri, 27 Oct 2023 12:59:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: cyttsp5 - improve error handling and remove
 regmap
Message-ID: <ZTwWmHC7Wcd5iwqS@google.com>
References: <20231025013939.353553-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025013939.353553-1-james.hilliard1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tue, Oct 24, 2023 at 07:39:38PM -0600, James Hilliard wrote:
> The vendor cyttsp5 driver does not use regmap for i2c support, it
> would appear this is due to regmap not providing sufficient levels
> of control to handle various error conditions that may be present
> under some configuration/firmware variants.
> 
> To improve reliability lets refactor the cyttsp5 i2c interface to
> function more like the vendor driver and implement some of the error
> handling retry/recovery techniques present there.

Sorry but you need to elaborate more on what is missing in regmap and
how vendor code is better. In my experience vendors rarely follow kernel
development and either are not aware of the latest kernel APIs, or they
simply have the driver written to what we had in 3.x kernels and have
not really updated it since then.

> 
> As part of this rather than assuming the device is in bootloader mode
> we should first check that the device is in bootloader and only
> attempt to launch the app if it actually is in the bootloader.

I would prefer if this was split into a separate patch.

Thanks.

-- 
Dmitry
