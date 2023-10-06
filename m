Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D47BB0E9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjJFEfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjJFEfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:35:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF29DB;
        Thu,  5 Oct 2023 21:35:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c61c511cbeso2672215ad.1;
        Thu, 05 Oct 2023 21:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696566949; x=1697171749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=daTh0xMFvxN23blHxI+gAT68kyBArx5W5lkuWAo1sT8=;
        b=Ojf9w5wJ0k/2CRqWiDFkBHApEyHO86GUM9xyOF8teono0Pp22HGKTk7PBcu1xa9mgx
         O+E+2jw9nZ+6mH7NoPZ6dLu1AeFKAph6KryksiNd+Vt9f4LvxcMQXlNPNKbg4KIi0xkY
         uAljNOBZvt1dB5qw3LUxW1U/b6O3tfMp0QD9XCubpylD//aAjaJ8KyrgRoXOzFNdYSY7
         vZjbCpeXPXNVZdrWggd2+bkECR9jKZC9IhbkcBxtIK/ObWGnkBsT3TOXkH2uCS3r7/DV
         nj3a0kAVAqU4Tq3HDLDWfwRp9XF5vWm6IAZ/l7z5xWLDhIYRepvUuOSeiXkv+0JCLwRx
         QH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696566949; x=1697171749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daTh0xMFvxN23blHxI+gAT68kyBArx5W5lkuWAo1sT8=;
        b=jBwZfVQibwJvXSjeIq9/Axc4i6Dn6MDAmpKFe40LcV54w6saDJ0wWg5RlalvG2Ko3O
         wfWkGITcItXU8EIK5blTmlMeiEyRjaC5Ckm36xuAjqDVskg4HpEKd+V6BQqs/kAt5zTb
         d5UbLUrZNWwbYRVFCe4IWWdQaHvKHwQt7dFXXKNv+IzKI48MsL6iiO1M4UzbOs6oCfU4
         8LTmA16L26lwCTYHaIi368Yi1rFTxTbFFHvvsDa85x48TNxr5LRr3bGuIzvTeWrjXxa7
         LVDtdXHYxm0dzPrU+jpP78FOLEsF5hIYV8j+VxbLXyfH2wGXkdiW+bpXHk4kN8phJMV+
         49xA==
X-Gm-Message-State: AOJu0YxIgIYylgGBhHgEeYp7KCZkU3P7V4fwTHYCcBueNtNqy1pft32t
        wCrJohg+sorJh+PHgYSn+uU=
X-Google-Smtp-Source: AGHT+IHMgNySTDWuvdltyf83eVz6rdlkBcm1Z/wAeTLHVV6QePo6bGPtBcfd8Vx1rJkyKxb9+MrXOA==
X-Received: by 2002:a17:902:dacd:b0:1b3:d8ac:8db3 with SMTP id q13-20020a170902dacd00b001b3d8ac8db3mr7532594plx.6.1696566949241;
        Thu, 05 Oct 2023 21:35:49 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001c55db80b14sm2653217plg.221.2023.10.05.21.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 21:35:48 -0700 (PDT)
Date:   Thu, 5 Oct 2023 21:35:46 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Mahesh Bandewar
         =?utf-8?B?KOCkruCkueClh+CktiDgpKzgpILgpKHgpYfgpLXgpL4=?=
         =?utf-8?B?4KSwKQ==?= <maheshb@google.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Stultz <jstultz@google.com>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
Message-ID: <ZR+OouM1rSXX7vyV@hoboy.vegasvil.org>
References: <20231003041701.1745953-1-maheshb@google.com>
 <ZRzqLeAR3PtCV83h@hoboy.vegasvil.org>
 <CAF2d9jggffd6HtehuL-78ZFPqcJhO+HAe1FX-ehXc5oBmZ72Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2d9jggffd6HtehuL-78ZFPqcJhO+HAe1FX-ehXc5oBmZ72Dw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:12:44PM -0700, Mahesh Bandewar (महेश बंडेवार) wrote:

> I replied to all your earlier comments, which one do you think I had ignored?

new enums -- go back and read my reply again!

Thanks,
Richard
