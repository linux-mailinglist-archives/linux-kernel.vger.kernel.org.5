Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2451C810986
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 06:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjLMFjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 00:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjLMFjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 00:39:42 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE47D5;
        Tue, 12 Dec 2023 21:39:49 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d9d59d6676so4976515a34.1;
        Tue, 12 Dec 2023 21:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702445988; x=1703050788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKxo+NWd52Qq2mFzLOgBSlef/7x2+YjxI+q/IwUpiSc=;
        b=F9XOlGEi84C6wYKMBA/35yorw3dmpvW4fJZbpKWN2J/MF42xElD6DPzpECmGPT39Wd
         yPymVZeC5Xlk40FJB0049N0j+pjWNhr2vHJPyCwXKg+UZ9rO2t8nJHJNJ+S3aXOgH592
         gUYddculRgTDN3liVnqGkZPXe3fEb/8ehoftqc+9kejPzM2yZZ0MxEXzEOyKvgkL7sHt
         ZgvrYxz2jq9vYO82cwBqaO4azgyWwHPdDeWnp+LLBou6BVYxq3EJKmtJhAR8DOTVd2hk
         8Klns5wNaN+7imojsHAomnuZ1zsrRhtyqTWzRr+7taEQYAWkPsi9tEuAJgLqXXlkW4xo
         YqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702445988; x=1703050788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKxo+NWd52Qq2mFzLOgBSlef/7x2+YjxI+q/IwUpiSc=;
        b=Mtr9bRScIs4oU5QdW1iHkQ7Gq3UIDenYhmj3lOc99zENZF0LQT5YtPF2GwBkxsfxLb
         YUncTmOqc0uM0JTcaOPEWCyx9RRVgzBZJAqUCHsFc2gB5+t/rMTw9aDPJgo5TtEDV9bo
         KYnLHznbSmujvnrol/MJ1B4whtiSG8CM5XE8xJwITqYiFFvFZXNZNNJJTcprF6nVNVmH
         uNlBlRfNXBupboc77+m/QXvO6q46JTAyImB79sfy/stqLAGeYJLALhiw0g7auyEXT5/1
         C1uGh6fJUmpsY3ioS8ceNJhXGH2GboYVsAOwizuHa/nRoYIa5/Vnzn7NdAsmM8ljdna2
         54/g==
X-Gm-Message-State: AOJu0YyllaRCW5ykAtE/4Bi/5efgbX+v+i4bpuvrWyXLaf+xdtbaqGKi
        VI7w5cZaIM7yuZEhqtOMqCc=
X-Google-Smtp-Source: AGHT+IF1kJDoiT9Kq4/GvhzmTFujZZaw/N609aTI2oRx8/AHTsXrR647NDwSDAOFuBrJ6ZalNDMX+Q==
X-Received: by 2002:a05:6830:2092:b0:6d9:fd0b:c289 with SMTP id y18-20020a056830209200b006d9fd0bc289mr6534351otq.15.1702445988280;
        Tue, 12 Dec 2023 21:39:48 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:96c1:256f:67e0:c0db])
        by smtp.gmail.com with ESMTPSA id ka8-20020a056a00938800b006ce7f7f1a94sm9087906pfb.208.2023.12.12.21.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 21:39:47 -0800 (PST)
Date:   Tue, 12 Dec 2023 21:39:45 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Input: Small regmap improvements
Message-ID: <ZXlDoREMsLOn8ukw@google.com>
References: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 01:43:37AM +0200, Mark Brown wrote:
> This series has a few small improvements to the regmap usage in some of
> the input drivers, there's nothing really important here but it's all
> nice to have.

Applied the lot, sorry for the delay.

Thanks.

-- 
Dmitry
