Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1C7B67B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbjJCLTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbjJCLTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:19:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6E0CC;
        Tue,  3 Oct 2023 04:19:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so1292497a12.1;
        Tue, 03 Oct 2023 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696331942; x=1696936742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzEFkY7TkXHrl69Xqba/YHjVd67aEYiCo5we8WdB1Eo=;
        b=kSEroy+KDuFEgE/x4rHIuw9s2oiTPh4MRl69U73bTRrDLeRCmPcuWo+nA4OvPvKUqV
         DUy/HJNCRf94GMRR9QDqtm/K1aBbqdpA11eqDElkj3vfhljczkkO2vttyczR3c/K0vZD
         iYfHreOpD6cUc8GaTLu2YsegNfxtGxgbV6hwG3Qrm3jSuISWI6qf8vUCvmjGONlWGqqt
         9ibTW4FUqE+q6cZZwFkUyMg6WmFogCu/yhGoKB24TUxX/XkuO1UiGxdpjAcEwQyv9Cnx
         x3fgq21AXFklrehgQcDm6qmpngwZDr9FSlq/iNp/+tJp/+MZk4tm/l1kxal0sBOpFjh6
         52hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331942; x=1696936742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzEFkY7TkXHrl69Xqba/YHjVd67aEYiCo5we8WdB1Eo=;
        b=n41Q1L5jEOuLSj0sbGKv9mhh4cKaYH14CMNnrV4BA+NN5PpZNjbHykN9vV6K36H37H
         sf0IpLkMWu3cE/5skBWETPZlxHRnQuSvPDO11OaMjvPaaH0F6j5PXzzl1PSuQ+M3nKQa
         As3rv9TFxVyuHno4+Q+OTF7NBVZM08VJ9mjJiBxnXh+sstPex+sGUQeDs3aIKV9bgnLx
         2EeOnHiUrpUimRW+WMpn2mTmK3Q/YsLvQubrqrhckdHCOqAFS95V4/Fjf3Q5ZHNssN/q
         hQuP3eEaHlLFAVsgq6JiRlMewuoKRwf2NxXaJD+ac550jg38uCxHOy5EUGcfsgxNFVo4
         CV0w==
X-Gm-Message-State: AOJu0Yyk4UpaVDv4kXQB7cJS0S3F3FjNaV6glevOr3jUW5q8yxFQbrX/
        Mrek6IYeFwCX1fc+QZhPGjM=
X-Google-Smtp-Source: AGHT+IFAHKT/bInD5ELh5El8DOvGm9hCqLeBsQ/SLugLnQ+U+3Ku6vNTpvdZp3FvB/LcGcygLxl/oA==
X-Received: by 2002:a17:906:3091:b0:9b6:50d3:2a75 with SMTP id 17-20020a170906309100b009b650d32a75mr3467745ejv.48.1696331941727;
        Tue, 03 Oct 2023 04:19:01 -0700 (PDT)
Received: from primary ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906078c00b0099ce188be7fsm906949ejc.3.2023.10.03.04.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:19:01 -0700 (PDT)
Date:   Tue, 3 Oct 2023 07:18:57 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v9 08/14] USB: typec: tps6598x: Add interrupt support for
 TPS25750
Message-ID: <ZRv4oaj68KnNMMc5@primary>
References: <20231001081134.37101-1-alkuor@gmail.com>
 <20231001081134.37101-9-alkuor@gmail.com>
 <ZRu3P7Dlo7CiQfFK@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRu3P7Dlo7CiQfFK@kuha.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:39:59AM +0300, Heikki Krogerus wrote:
> On Sun, Oct 01, 2023 at 04:11:28AM -0400, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
> > 
> > tps25750 event registers structure is different than tps6598x's,
> > tps25750 has 11 bytes of events which are read at once where
> > tps6598x has two event registers of 8 bytes each which are read
> > separately. Likewise MASK event registers. Also, not all events
> > are supported in both devices.
> > 
> > - Create a new handler to accommodate tps25750 interrupt
> > - Add device data to of_device_id
> > 
> > Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> I'm sorry, but I just realised that this one also has to be in place
> by the time TPS25750 is enabled in patch 4/14. Otherwise the series is
> not bisectable.
> 
> I think you need to refactor the patch order a bit:
> 
> First come the patches that prepare everything that needs preparing -
> introduction of struct tipd_data (without anything TPS25750 specific),
> and so on.
> 
> Then you have patches for things that are specific to TPS25750 (small
> stuff just merge together) if needed.
> 
> In the very last patches you finally enable TPS25750.
> 
No worries. I will aggregate all the patches that are related to
tps25750 into one patch that supports tps25750 implementation and enable
it. The remainig patches after enabling tps25750 are to add trace
support.

Thanks,
Abdel

