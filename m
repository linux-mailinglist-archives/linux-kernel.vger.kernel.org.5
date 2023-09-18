Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE417A52B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjIRTIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIRTI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:08:28 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4700A10D;
        Mon, 18 Sep 2023 12:08:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7926b7f8636so120679439f.1;
        Mon, 18 Sep 2023 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695064102; x=1695668902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqCRbM8zWaMYwFEICjMVLMaRfdQXKAkuVvdRyDoo4V0=;
        b=Zd/y4bShzuR/oR/kIxSxxYPg30dsiFQzJQ/LlOr73UzXm1XMRiXkxLUB/hSS83Py/V
         FDjkxDyBnYirKu1HJAaLONSvlJPrmNiLK6RxZJWMwZm9OFVeKzr12HrqlqoDA98B97nj
         z0qOfbiu/9Koe16FYvkM8V1JlNtazmY6Ktp4PfLJUpfzAq5i1U7ucETm2F/eB/gEGC2B
         vGPonPYN50oRTmQ5wc24iWG2dvs3EqN3jMOxf0OVaw0BtAg8aoIqA5sThYwsmFq5vrwc
         VC0nURgmVNHOR3gyfGqZsyIUp1tdk1MD6id+4XPg6gZCIOUb8zjt4nKFzjVmnNwNnthU
         DgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695064102; x=1695668902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqCRbM8zWaMYwFEICjMVLMaRfdQXKAkuVvdRyDoo4V0=;
        b=YzPiABPt1T/bxi/N+n3HH2/F02mmUurlJgkEixV4e1QkUWiAVEsV6PHc3T/3rve9I6
         i+DssasPl38+0HT7YzC3crJf2oNCiqnOnAfijZrOazyL8tbsPiZPoR+ml0hTM5cIZlxU
         dmA6bpUMtGDk4l3y7UnRGZ7IXygwoKP6sRUKQiPnhRj9pOCVRk5qKbXr9CYhJr24esKY
         Uxi8gv19YNzQq9wTGNoG6zUcHJLl7NWEJiqAn17hr2qbpaC5kXyyjB8QBDhIrJUKsUAI
         gqh2h0r18W7g6wE+IR5vWjXPssy7R1ePa8/hz+LrgaIy3n2FOuXs2lxaiVuZdPY1LWY+
         n+yw==
X-Gm-Message-State: AOJu0YyWx4oYCPpBGwlAF+F0FndgIriFaNaoBblxizqCAKZr5WYK80nm
        B/5mTEK8yom1r7hpL5btHHAytulxmPY=
X-Google-Smtp-Source: AGHT+IFsr9Iem9VlleAniloax8Hdbxp8YsIvL0FVsNCnBb4lbwWvEFCTBePRqtQX6Fv1Dwk+nOOoZg==
X-Received: by 2002:a5d:9da4:0:b0:79d:2d66:9b3f with SMTP id ay36-20020a5d9da4000000b0079d2d669b3fmr691641iob.7.1695064102498;
        Mon, 18 Sep 2023 12:08:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t8-20020a02c488000000b0042b03d40279sm3078319jam.80.2023.09.18.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:08:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Sep 2023 12:08:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Timothy Pearson <tpearson@raptorengineering.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH] hwmon: (adt7475) Add support for Imon readout on ADT7490
Message-ID: <b2a7fa83-ec38-4b47-a6db-82d263e8f451@roeck-us.net>
References: <20230914223947.829025-1-tpearson@raptorengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914223947.829025-1-tpearson@raptorengineering.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 05:39:47PM -0500, Timothy Pearson wrote:
> Add support for the ADT7490's Imon voltage readout. It is handled
> largely the same way as the existing Vtt readout.
> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> Co-developed-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>

Applied.

Thanks,
Guenter
