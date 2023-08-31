Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880D878EEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjHaNrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjHaNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:47:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8E71A4;
        Thu, 31 Aug 2023 06:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C3B6B82292;
        Thu, 31 Aug 2023 13:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F242C433C8;
        Thu, 31 Aug 2023 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693489662;
        bh=yi0fQ9YqnX6rx7PGPf8STQH7i5wvSQI+xOSkrpzGj3g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iILd6VrngAFL+ANsICTW7Mjzeqv5qxHtvFbjuXy7Ob941VbWvJCwJeF1Rds+foVM7
         EQZWPdT6LX3J378qz50WNqhTBK/LJ+T+Mdos7TNCH2Phb7c1LVlntH1V86fmGDtlzJ
         gU6LSVIqJeudAs9C0SV5jZIQF7ZlSKtCNIVQSgY5Gos0ruX9qaN1MztdPmSgo2p5b8
         hhjxsSTY2Atktoi5p80k85IEIMRxF+tuuQBRjOKkn1UGS4lMeGVDFw7OIc+xLAt+0s
         grHSS6OjVp5d6mloG8eDLNldJSNw/ScL05DM7WBbICaq94lIJVFAk7OkZ1pfkyVj21
         LDnH3qBnKY/eA==
Message-ID: <6dad0aa6-b1bd-96ff-4c88-89a59783331b@kernel.org>
Date:   Thu, 31 Aug 2023 15:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Rand Deeb <deeb.rand@confident.ru>, Michael Buesch <m@bues.ch>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru
References: <20230830082759.23336-1-deeb.rand@confident.ru>
 <4c6d01bf-1a0f-27de-54e1-4afdcf4bc8d5@lwfinger.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <4c6d01bf-1a0f-27de-54e1-4afdcf4bc8d5@lwfinger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 21:50, Larry Finger wrote:
> 
>   /* Calculate the speed the backplane would run at a given set of clockcontrol 
> values */
> 
> Your patch has some technical problems as well. The subject should be "ssb: Fix 
> division ..." In addition, note that all your if statements have an extraneous 
> "3D" as in "(m1 !=3D 0)". To me, that indicates that your mailer is not sending 
> plain text.

It's sending everything as quoted-printable. Nothing improved here from
their previous version.

Best regards,
Krzysztof

