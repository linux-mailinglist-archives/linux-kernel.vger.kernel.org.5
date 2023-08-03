Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8B176E6B2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjHCLUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjHCLUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:20:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE21706
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:20:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68783b2e40bso539116b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691061619; x=1691666419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjhg/Kd2S1v67soZs3q2/nq/LS7cbUkbo5ANx73wiFQ=;
        b=CYvedE7a568zh9KbVOq8I7D3FCbMdP2NRSZhm+d1YPGJ5/SOVVaO9O01t1tqf5oI23
         Wt4Lc4zDps2nzbftEdaWkxDMtPh5dtxwjzwHISLOG8erulxLZtS9KxV0nb5kF0qsuvJ1
         eZ1ISNrUKekLRNREcsCvgBlZoivMl2nIxL99TaTLho/BrZOBrmU8Jn92I1BKolqK8E7o
         IeVj9GqcnOI59wnjlOV6OJChbV2UryRkicCVykgJhkfbQmy09Ti/WthMF1PeUt88hcag
         kvxNy1qIyzKZKbPZNdvbSh1ulPrYIuS9Sn7AbKslM4LUsJN10+YoC0J7Gj5naRorV+6F
         1rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061619; x=1691666419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjhg/Kd2S1v67soZs3q2/nq/LS7cbUkbo5ANx73wiFQ=;
        b=jUbQdJ0F66AaaFhagCypOdtlXNQLzYTUmN99rQPICxcZRXA72Vl/ZakdXtZYPY01FE
         Pxz/KzwPBNkEXo+MFaVHf864TkSzjSY6Q6HABZRI3n7L/Ov81XkNBHvG71Qgz5YYKy6b
         zl7Hv1isLjNXQItvkKtO7/BhhmCVImzkjctmbxSkHpOInlIsB3g/MGIBvSGJPjy9j61T
         a2ykaW+CmDQnARmXK23U8jZCjgTvZEUw/SlQYJwgLLmKFTLWxZrUoDI8H7R4bq2+l6DO
         9pCWDy/9ZclZVUFZRhMzkaTaNnupBZ5phuMj3Da9+bVvxvlu7ddkm8Yo3HV+/gNEj03O
         Xj/Q==
X-Gm-Message-State: ABy/qLYknir6FDloPIl5SwRpZgT1Ao3OdfMtGzdC/2oz/jF7IWkhfFlL
        ix7KCY/4+SAQ6/DlsR0uejSGaw==
X-Google-Smtp-Source: APBJJlGr4lg3g8jpdKrboSL9rsSMX+CRQD7I8jp76L0TUxMFUrZFjqX/v4G1MvxSAmdhy3TztU9b2Q==
X-Received: by 2002:a05:6a00:1a56:b0:687:4a3d:8fad with SMTP id h22-20020a056a001a5600b006874a3d8fadmr9307809pfv.16.1691061618521;
        Thu, 03 Aug 2023 04:20:18 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id e18-20020a62aa12000000b006875493da1fsm4567108pff.10.2023.08.03.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:20:18 -0700 (PDT)
Date:   Thu, 3 Aug 2023 19:20:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf doc: Document ring buffer mechanism
Message-ID: <20230803112012.GA1783639@leoy-huanghe.lan>
References: <20230803035037.1750340-1-leo.yan@linaro.org>
 <f26c9130-71f1-9849-36bf-4da7d9394fe1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f26c9130-71f1-9849-36bf-4da7d9394fe1@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:36:07PM +0200, Thomas Richter wrote:

[...]

> Great work, just some minor wording issues.

Will spin a new patch for following up your comments.

Thank you for reviewing and suggestions, Thomas!

Leo
