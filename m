Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A07B771D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbjJDE1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjJDE1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:27:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD90AC;
        Tue,  3 Oct 2023 21:27:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c61c511cbeso2699695ad.1;
        Tue, 03 Oct 2023 21:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696393627; x=1696998427; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+R3tIz4MjsHho9Vt/CuKdfOqhm5oHHvOncpSM4H43xc=;
        b=WkQtVX6lwwA7B76TQOsyD5F0A9WzXId/Z+9ob1VRp+BUURWa2CGwyO7dNz1L0oKFX/
         4e5qLJ13s8adkU95SiDimIcLH6uWHaPUpxB0elX7mQFrEm+Vmj1Ny04IKbdfLfMYvl+0
         WkuzSsRH/1ZExD2fuMJZ1k3Y9wK0qJdweSZMpGxqcgrvWAhfd2GrMohagoie54ic36V2
         s02WclSRSnA/dzS8manTrsCmTE+2EdJgO7sr8tgSI/UsQCftrWNwgu7sKH0mZ3E2Ymrn
         7cxqgQD9xYMDy7+hCTDvI0HYAF6F5/1jfAgMWCKYt0lwduopUf/JtG2z+AoZsXrfNI6O
         ZdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696393627; x=1696998427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+R3tIz4MjsHho9Vt/CuKdfOqhm5oHHvOncpSM4H43xc=;
        b=N7CNShFeQ9EKlCHINf1qQIZ/bfGOSVprRTu7iG3waZcnszhp0t4gXevXxiBUrzHCe9
         snPQO/IgQ7FCG3hFH5fYR+MDe4Wmlwuo616iiFdUuXWYcPdbl6gpLdYcg/R6YyIgBVsw
         AAq/xTgwRbFBobUBjF5FahIrbKQOVKf64j/4phPZjLKhIaQoS7XQHWbmlo9g71NnDZe7
         I+wWnXLgJIbtXjdS+9jcEr1VT6TFJOhVlHAhKYtdzXOwhFPrBRrkV4dUzXZFfgZDODjY
         ZRlH/fD0a5aSAPGJRsoMHqba6m5qPogLjxq8L6FvU33McmjwKNKC1LTV61hbMs/Ad7+5
         pGqQ==
X-Gm-Message-State: AOJu0YzCC6t6SCnvv0y8Z3puK3+YnHX1V2WiPa5GdIij0Qlkdl7FNzam
        6ynLz/dNh0uR9qgdjyvz79Y=
X-Google-Smtp-Source: AGHT+IESQah7cJh7JmYXksGabVWRzN8oD4iR878UDZ9HcxTCokbPIzsh301ZwJv9mHBk4F6rn9Nhug==
X-Received: by 2002:a05:6a00:1d94:b0:690:d314:38d with SMTP id z20-20020a056a001d9400b00690d314038dmr1532940pfw.1.1696393626718;
        Tue, 03 Oct 2023 21:27:06 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7870b000000b00690cd981652sm2186550pfo.61.2023.10.03.21.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 21:27:06 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:27:03 -0700
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
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCH 2/4] ptp: add ptp_gettimex64any() support
Message-ID: <ZRzpl6AfzCVSmIhx@hoboy.vegasvil.org>
References: <20230929023740.1611161-1-maheshb@google.com>
 <ZRiQqLYpzJGbiqYX@hoboy.vegasvil.org>
 <CAF2d9jj4m4i278PN3F91VVudEG4nLFU8PJqk9Dnkqf=QOXTX0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2d9jj4m4i278PN3F91VVudEG4nLFU8PJqk9Dnkqf=QOXTX0A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 05:24:43PM -0700, Mahesh Bandewar (महेश बंडेवार) wrote:

> I'm not sure which one you are referring to. These defs need to be
> UAPI and the one defined in time.h are not all relevant in this case
> (we just need only a few of those) hence the definition. However, if I
> missed something, please point me to it.

You are missing this:

> > > +     PTP_TS_REAL,

#define CLOCK_REALTIME			0

> > > +     PTP_TS_MONO,

#define CLOCK_MONOTONIC			1

> > > +     PTP_TS_RAW,

#define CLOCK_MONOTONIC_RAW		4

See?
