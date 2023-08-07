Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54EF772D22
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjHGRhM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHGRhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:37:10 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED24107;
        Mon,  7 Aug 2023 10:37:09 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56d67c5e87cso205878eaf.0;
        Mon, 07 Aug 2023 10:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429828; x=1692034628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCQUve8Vagg2X8vXCVBWX8BBtpGA+YDuLqqwWNPe/Hk=;
        b=LCK+j3NiS0Psxm0qT1ueIUxL44NNg9nwMphk3YLPrVNU89/uqEy9ujULlWykEv17us
         9z4hR5Kx1ZQKWnOus7aoAidENmaumKsPtTEbRPC2Zkvo27drN97/y5ImWUrV5J3Qj4GP
         9eqQMx4hde8Upj6UJBCP0ulXlc9Ic1q9YpBUV3uLAaINgTmRlR63QW9gZTfaCYrLBnaV
         ybMicM9ErQtxlZR+3LlAwHIHurXUJRNbkAxXz0X0MQdYRLkzgHQfPzB8LEVxK/HaKAUV
         r7j2G7DDEjveUyGiORnIWcnpR26e1UPkIWheMdYDNmAAoXLrI7IH5np6o0ImJBRFwpe3
         VJIg==
X-Gm-Message-State: ABy/qLazrHJDWv6W1ch9WWpoW9htZhby675Awou8QQeUjaJd8F4SEOhT
        Cwqc/LIGv79KiEdmSlPcBiT5XTCNpJvbQk8dRtM=
X-Google-Smtp-Source: APBJJlGStwyqYpvysRXo2djgk7GfihDl4coG+Oo8uIUh8grNj7h6POAG56vsYq86TwUCm2yDGnlGpZoxeCTj1OjCd6k=
X-Received: by 2002:a4a:d027:0:b0:563:3b56:5dc1 with SMTP id
 w7-20020a4ad027000000b005633b565dc1mr19522081oor.0.1691429828594; Mon, 07 Aug
 2023 10:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230807123806.700370534@infradead.org>
In-Reply-To: <20230807123806.700370534@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Aug 2023 19:36:57 +0200
Message-ID: <CAJZ5v0i0t-cTSBG=_i9b84CqBBZd3A_N_iu-WBw37nDsLFk0dA@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/cpu: Cleanup of INTEL_FAM6_foo
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        Tony Luck <tony.luck@intel.com>, luto@kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        srinivas.pandruvada@linux.intel.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 5:07 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi,
>
> I seem to have missed 'spring' but here goes...

FWIW

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
