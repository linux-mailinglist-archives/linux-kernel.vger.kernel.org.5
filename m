Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3AE7D82CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbjJZMhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:37:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240E192;
        Thu, 26 Oct 2023 05:37:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4084de32db5so7124885e9.0;
        Thu, 26 Oct 2023 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698323868; x=1698928668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fj+lNJJuEsuS8tAi4d2u6fdHrfkNu9UmtMbCGXcrmgU=;
        b=dQVzL5pD6FSaSBKpOqvjUZuBZ5bKHJwAcEFdwMeIew+u7VT+mAdm96vK0+2ZXcSEyt
         vH40wALiv3BbDhxeyAe/+IjKVYxNzxz/ujw/e3Zs7igQyd8QT8CeNKlGdh83dFCWMk2R
         Qjvm42fhGJGmOTvJOwBS/e8JmZMPC1kSGv1J6sRakel6j49/ZEpSgAH3OdEAiUVRqXU/
         cOoiZAD05rbv2w3ODtO3iv26gJXPzna70zXEz+LmG27tGkj7qpZLlu4TGGCb1J0/RQQQ
         Md3W4mSQgYeYyNK4I+ZtW20lOZpXnO8f+eEcWT1hplmJKF+A4kWanOBGfY0tGVxhDrQO
         reQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323868; x=1698928668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj+lNJJuEsuS8tAi4d2u6fdHrfkNu9UmtMbCGXcrmgU=;
        b=SbfIFq0GIYJuIXoxpOmMmqtiwDOy7Ck0DyJHWKnkMc35Gtul3m5ijPbWUxbOjtGsxM
         Lky6K6mGhxfTATqswtIVd0zUljv+w6PZcZRBps78JozWlNa8Y6tNhFlfFfyAGv+4PovT
         Z/foCvze2liH+MMJHPVDpykzDwYSU2fClBzHMbbtnVrWIomNcvR+KW09NVLwbtgRGudd
         fjMff9dmHxpW+FFBkKCdgFvEEc9PuYM3HUPGEZRgaYZxcLsmbRLwfm7NBIuCgfidTeoc
         9QYDAO2ojC+HIhQJfcxzk8YsUunuj7u9bHX9rSBacLLflpp0gdFQOAsdqbpAMrSS6GMI
         O9Kg==
X-Gm-Message-State: AOJu0YykrwyoCG6kSqcD4/fjjc8veEsnTExI9QCX17OeFg9b5orjEGV0
        lu289TZpIODcQylW0J2aZhnaPDc4dK0ISA==
X-Google-Smtp-Source: AGHT+IGhRaNy/DDQgo5NKfSuUIA9wsEew/p5BFi/cKsdQ6qGbtCSlW0lQMBEjodYAfsI6RAmxCrUTw==
X-Received: by 2002:a05:600c:4f45:b0:404:4b6f:d705 with SMTP id m5-20020a05600c4f4500b004044b6fd705mr13830380wmq.17.1698323868142;
        Thu, 26 Oct 2023 05:37:48 -0700 (PDT)
Received: from localhost ([2001:171b:c9bb:4130:c056:27ff:fec4:81cb])
        by smtp.gmail.com with ESMTPSA id c1-20020adfa301000000b00323287186aasm14272097wrb.32.2023.10.26.05.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 05:37:47 -0700 (PDT)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id f1ed972d;
        Thu, 26 Oct 2023 12:37:47 +0000 (UTC)
Date:   Thu, 26 Oct 2023 14:37:47 +0200
From:   David Lazar <dlazar@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH] platform/x86: Add s2idle quirk for more Lenovo laptops
Message-ID: <ZTpdm72pFkXNjWeH@localhost>
References: <ZTlsyOaFucF2pWrL@localhost>
 <e2370602-256a-4c30-b73f-1552d7d8bf22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2370602-256a-4c30-b73f-1552d7d8bf22@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023, Hans de Goede wrote:
> I'll prep + send a fixes pull-req to Linus
> with just this single patch tomorrow.

Thanks, Hans, both for taking care of this patch, and also for the
sleuthing on the original keyboard bug.  Much appreciated.

Cheers,
-=[david]=-
