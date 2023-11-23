Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1177F581A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjKWGVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjKWGVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:21:14 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA4110;
        Wed, 22 Nov 2023 22:21:21 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf79a1e6c8so932135ad.0;
        Wed, 22 Nov 2023 22:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700720481; x=1701325281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKEdH0ZwdUoNKkeGpsCW7ySfBW8S/qwXt1FLa+Woc5Q=;
        b=QUb2NuNOlvAR3HPpWbO94CTzp0MFk3VOR3MVqqh8AVzjBE2lO61lI+1nzL2z4Pomy1
         Tftl3PDqXvGmfx7gyxh4bPDlZqtlhxSALxnuvmGNX3FbiMQaNvM41oc9bq9T+DLECkJO
         /gxPBACYF/p3mCKqqW5u/oNMrDCCwQBH7CMyMZNcFbzczVKPU/X6IdMvz8nbayjbU6FP
         WXS6gJPyR2J0u3NDNQ3UTLGNSaD2ezRdbDPsV30COrXTRV6q9o7hXEWx7dJiilsni4F6
         TOIJc18A/xLgMUVcmWjfq5qcmqRDCJjAdDxH1SWS8h0kO01VKDCdtpwdJeI9dFLjvWDf
         2bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700720481; x=1701325281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKEdH0ZwdUoNKkeGpsCW7ySfBW8S/qwXt1FLa+Woc5Q=;
        b=TYSlK12EOyE1M7AND32U/kd8V2dAZjFK3BT4R8U49Ua58TxdUX8h0QZb0DRlqI3tiq
         nIJtCWdhVLsHJ+nP/dmgwPjqqgctgLR7ntojzBVP66930Khz8/QEXbgMV0xQzzt1jUpx
         rOSyf0lVJCjCakzps+ATbgPHw7V1K/P5CrfmF9bTNo/nsCBG25BPGjRd0nBlZvw9jRCx
         f3iGXCTtHdQ6KxG8FySE95casqwiPAh9J0Z7L4Kn2AEIkRKWcG86n1/QZ6hppOgBPQd3
         rqmxeYcWtd3+Je9DNZr+q1IZwS4wSPAXZFZ14jTvDUcOpu0HSqtulFjQLJcI+6QyqcZX
         A4rA==
X-Gm-Message-State: AOJu0YzK3jjfJDsO/BKweaoOQAoonTndJFZINhj+/P4QXUZlyYf6fLke
        eLQ3Bl5GyxWj3ggoqBNI8G8=
X-Google-Smtp-Source: AGHT+IH7FPv3CE4beFh3fe2WnQA1th0QiOX5i2WEz8gDzrCmQrknUbis3uYa0pNrLHuAWlJm8kgEPw==
X-Received: by 2002:a05:6a20:daa3:b0:188:67f:ff2c with SMTP id iy35-20020a056a20daa300b00188067fff2cmr5957434pzb.0.1700720480875;
        Wed, 22 Nov 2023 22:21:20 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090282c700b001c5f77e23a8sm478677plz.73.2023.11.22.22.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 22:21:20 -0800 (PST)
Date:   Wed, 22 Nov 2023 22:21:18 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Sagi Maimon <maimon.sagi@gmail.com>, reibax@gmail.com,
        davem@davemloft.net, rrameshbabu@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maheshb@google.com
Subject: Re: [PATCH v1] ptp: add PTP_MULTI_CLOCK_GET ioctl
Message-ID: <ZV7vXuJMMtuxZyTT@hoboy.vegasvil.org>
References: <20231122074352.473943-1-maimon.sagi@gmail.com>
 <20231122201058.0bfb07a9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122201058.0bfb07a9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:10:58PM -0800, Jakub Kicinski wrote:

> Please CC maheshb@google.com on v2, he was doing something similar
> recently.

+1

Thanks,
Richard
