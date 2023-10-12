Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E1D7C6AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377602AbjJLKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347104AbjJLKPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:15:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1CEB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:15:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso758777f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697105708; x=1697710508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nGBRtscR5XFDxdOEvFyr/E+oy+5VNzI6usKYmeqNS50=;
        b=MiD8CQmeMKyPEpIgMLAsKr0oRB3e2v7zP/g8r3qA/0QN84vgCuNUSCwx4pvG/81LK+
         QrFauRZtZpMUeV4YHbV4oRE//xcM90Q9oEN6UdAna6P/OozwYylbZS6mVKY+h6daLx63
         mw2ftAaozJ8dBF8Zly+53CK6A1rIvMq4YXQmQlqUAGXv3fKhEKXgUCOSUPO7CllQd4h2
         l1wGfVSYDZkc944/OvbDfElC4OkzB/K+ehdIMfNKKAhlCDpAFJjhOw4+MEkW9Ac3aJnd
         Cw8oQSrvbxA9/uGhvvom9MdzB7wVU7pBoivOJ9uc9gJ5ViDgQWVgW5uZJrHDFMRmmICx
         XPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105708; x=1697710508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGBRtscR5XFDxdOEvFyr/E+oy+5VNzI6usKYmeqNS50=;
        b=eiEJSIcxqzikAX0H2sLuPE7uBtBj/82+oIgdwHwb213C/SyWSS8PQfwRFsZbnLfWPz
         +2QBlYoHwGgDbu/3cKCz1pmacS3MX6jKs0en71OzzG6TVyAi0Iu+4L/20sMTPPFJ4yGp
         IxLKrfCRDO4yvgiKo8DlaMWfUdnLXTWUvZzm9r++LyJryDlXMvri21QWXBBPKRIwHqvo
         1fGxArbLMFGz5Oh1997ISTUzXofwGV9Gg4wD7GEudgb5RBVK2DvSNKbI/Qod/xhN7cxU
         93JFioM/QU0FkMqwDXt6R+/gsjYwzC1H7U7frmXX7XNlyL9X1K6L+xaOi8XLWYh9/EXA
         LiaQ==
X-Gm-Message-State: AOJu0Yw4g8pFBKTDlL4yGxH3nRnbLk3pjOLMLYtlWwF0eMl6XK9eRwHI
        cer2L/hk3HALH98rA+h1NcV3Mg==
X-Google-Smtp-Source: AGHT+IF7ZOB1GpuF5uoZtYv82cP81Ykcjmt9UppAs2wf1pmdfGmQref1xRyVHDZlDqgkcVFCb/HFmQ==
X-Received: by 2002:adf:dd82:0:b0:324:84bc:d59e with SMTP id x2-20020adfdd82000000b0032484bcd59emr19004327wrl.22.1697105708075;
        Thu, 12 Oct 2023 03:15:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ba18-20020a0560001c1200b0032d8a4b637bsm2981997wrb.22.2023.10.12.03.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:15:07 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:15:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Archana <craechal@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging/wlan-ng: remove strcpy() use in favor of
 strscpy()
Message-ID: <848becd6-9f65-4316-a2f0-ebf2ed2f5758@kadam.mountain>
References: <ZSeD1UojAgrsOh16@lab-ubuntu>
 <f0c12a00-ad9e-45b2-9cb2-7a84f4f10ef9@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c12a00-ad9e-45b2-9cb2-7a84f4f10ef9@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:03:40PM +0300, Dan Carpenter wrote:
> The simplest approach is to do a:
> 
> 	git grep strscpy | grep " - 1"
> 
> But the better approach would be to write a Smatch or Coverity check to
> prevent these in the future.

I meant Coccinelle not Coverity.  Duh...

Also btw, sometimes we want to keep the "don't necessarily terminate the
string behavior".  That's rare and ugly, but it does exist.

regards,
dan carpenter
