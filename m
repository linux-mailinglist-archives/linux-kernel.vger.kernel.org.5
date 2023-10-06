Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1537BB11F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 07:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjJFFO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 01:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:14:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A471B6;
        Thu,  5 Oct 2023 22:14:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690fe1d9ba1so366718b3a.0;
        Thu, 05 Oct 2023 22:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696569296; x=1697174096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbvIh4emsC61M3uO5AOYSm7p42KtRtYejorlTut5jfM=;
        b=WwgeUQ2w2ZX7rKl/E334zUIoUyEvnD3Prw3Z7TcUlqhLVXbfbhZLcxupLApgXqu8Vu
         0Vr2TZThHwo/gy2Rd6064VZK6c9e9McazhRHahWOV0pJ3XUF9zK1QzGkZ9J+Rn3XAoOq
         Jerq2PcU691+vZSLB5rk0NzjTiZ577RRV56E7LRQFwXrQQmDumaf8BewIuUzA1FRA7gR
         q7XhEJOTVORkqvOTxFYeNNuUgXoi9g8YFW+JaEPrY2a+NGMKuKuXuKJcPvKl7UMChpBV
         YwW/tXIlvRJ9c3sM2nTb2oSCi4USLm4xi4Vj/tyHOffhu0iH0LzedrPJnSmKm5sRIEzh
         abTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696569296; x=1697174096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbvIh4emsC61M3uO5AOYSm7p42KtRtYejorlTut5jfM=;
        b=eEwwbbIjP87f0gjQz8RdEBK3XXu8t0pS/NTWaUtqaZsiKBcsXP6SW6PF7hH3iQzXfy
         Ygf1y4qJbu8egGNEyRdbyNbMCMhbX8JyikV8ySaNF4zw5fi+mMCS/KO7YZR9Ei66AARb
         pIV9W5Q88Qlxl5yimLYmqfhXQZbrMKDhwyIDmELgp0lKSxAey9Bl37N5kHUbpJqt4tO7
         i6ykRw6Zs2+gHosx9t3ytMSlQvhwL7LpFKh7OwV15+f5z6XifFcZ8UoLfW3RQCNuHa05
         wS4U6r98bIOphfY4lAHKIpCg4MCGv/sYbBpwfsFV7eId1HEv38hUvmRB5gRtKuDi9etV
         mbdQ==
X-Gm-Message-State: AOJu0YzmpcF99q0no8Z2yb5wFhh0ZwLXlsUxJ0x2MjJjrqRK4ls8ZZ/C
        NYlNNNu/G48s5Ocn+HWomz0=
X-Google-Smtp-Source: AGHT+IEWDbnhjGmpng9/dYTbeZphpz6QPuIfmRBR1OEe70CidIVIg/suP1vxru1ogEz0gYaYhDrLbQ==
X-Received: by 2002:a05:6a00:3ab:b0:68f:c309:9736 with SMTP id y43-20020a056a0003ab00b0068fc3099736mr7495840pfs.3.1696569295715;
        Thu, 05 Oct 2023 22:14:55 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id p25-20020a62ab19000000b006936d053677sm502912pff.133.2023.10.05.22.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 22:14:55 -0700 (PDT)
Date:   Thu, 5 Oct 2023 22:14:52 -0700
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
Message-ID: <ZR+XzKrxgpURda/i@hoboy.vegasvil.org>
References: <20231003041701.1745953-1-maheshb@google.com>
 <ZRzsWOODyFYIxXhn@hoboy.vegasvil.org>
 <CAF2d9jh46s=ai1Ykgk3Lsg8Nb6qRNY6bWPV3fVCTC_S95csyag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2d9jh46s=ai1Ykgk3Lsg8Nb6qRNY6bWPV3fVCTC_S95csyag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:23:27PM -0700, Mahesh Bandewar (महेश बंडेवार) wrote:

> Probably it's fault of my mailer-script which finds the reviewers for
> individual patches by running scripts/get_maintainer.pl but then
> coverletter is just sent to the mailing-list

No, it is your responsibility to ensure CC list is correct.

Thanks,
Richard
