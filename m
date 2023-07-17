Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF69756D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjGQTtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQTts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BAFE1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689623340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2rRzgR2bCR4WLQV/L/SdDZ43J6JQqvM6vx+FxfFLaM=;
        b=BxRnQPu3wILjD5g2suqbAlxADBqkznE+MfVxoVGJj5PMUZHfH6ikD5rnL5wHgfkfojYkho
        zrrjl5wMbux3hn3uRTHjFX1S/O5wQ0Y33tpvbLriRBEGFzpXQJcq18nanxc72t2oBcDsSh
        JpIoIacYV7ncRGeKJn+WISQCo4/Ik2w=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-qdzb-wvpPIW6Tam6yukUGg-1; Mon, 17 Jul 2023 15:48:59 -0400
X-MC-Unique: qdzb-wvpPIW6Tam6yukUGg-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7948241cd38so514549241.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623338; x=1692215338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2rRzgR2bCR4WLQV/L/SdDZ43J6JQqvM6vx+FxfFLaM=;
        b=Iqk5q7bVAijl7NKVvSO7MpXH1MwKE08c3ERf2OsAHL6kE7A/DEL0ZuHmuRLPCK/umG
         M8ZskMvLRHH6gpHcXGsXbw5Eqb7O1ga7Ap3fmf6SBnVmvfYCKclFDPBylPpkcWk9Z4qE
         q1GFpjXCG1oOxIl7V6p2cnCNot6iSMRIZzVrU4QuFl8lqmn7AIrQXAqOHjw0wIIcFrMG
         biduOkHjspx9JCcUXy+ivQkko8Q/36hA65ymz2wgXC7+tXgb9TIxagqNwP7URp1fq/zD
         E0QWIa8m5xly78MozS25PEI9oBURZJ/eYjX5+tsiaNZ0z8z3xplHVWB8jKlYsHWzOaU2
         Uqvg==
X-Gm-Message-State: ABy/qLZ0QMUB93iWgs+K7NZrOtoHPZ8Z2o/aGf+ZDYPWIr0kL+MNswx5
        eA+2q9hxEJA6pFixWQXKBa8hD8e1VJ1lCN2mFODQmDC131aWNW01UVjYLmfba61buukJd1huxWq
        isE7Cq90OEg1wHHuRwK/y0HcA/rvsAS+O
X-Received: by 2002:a67:e3a3:0:b0:443:5ec3:55da with SMTP id j3-20020a67e3a3000000b004435ec355damr5207079vsm.15.1689623338326;
        Mon, 17 Jul 2023 12:48:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEmuKfhqUNybdA9S/7JJsY6kGCiUUlRIJFJBn/SN8CN1hqWuSmyjKp1TapgDjsKCWociDChlg==
X-Received: by 2002:a67:e3a3:0:b0:443:5ec3:55da with SMTP id j3-20020a67e3a3000000b004435ec355damr5207071vsm.15.1689623338093;
        Mon, 17 Jul 2023 12:48:58 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id g15-20020a0caacf000000b006263c531f61sm154184qvb.24.2023.07.17.12.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:48:57 -0700 (PDT)
Date:   Mon, 17 Jul 2023 14:48:55 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [RESEND] clk: qcom: rcg: Update rcg configuration before
 enabling it
Message-ID: <e2xxoobnbtepdsplh2wv6l7k7snncbwssp43pttii4xnjj6egy@r24o4s6klhs7>
References: <20230712014812.3337992-1-quic_skakitap@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712014812.3337992-1-quic_skakitap@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 07:18:12AM +0530, Satya Priya Kakitapalli wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> If rcg is in disabled state when clk_rcg2_shared_set_rate is called, the
> new configuration is written to the configuration register but it won't be
> effective in h/w yet because update bit won't be set if rcg is in disabled
> state. Since the new configuration is not yet updated in h/w, dirty bit of
> configuration register will be set in such case. Clear the dirty bit and
> update the rcg to proper new configuration by setting the update bit before
> enabling the rcg.
> 

If I understand correctly you're saying that without this patch:

    devm_clk_get();
    clk_set_rate(rate);
    clk_prepare_enable();

would look like it worked (i.e. clk_get_rate() would return rate), but
in reality the clock is running at whatever the "default" rate is.

That sounds like it could use a Fixes: tag if so!

Thanks,
Andrew

