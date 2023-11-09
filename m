Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9277E6F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjKIQqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjKIQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:45:46 -0500
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Nov 2023 08:44:49 PST
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC643A87
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:44:48 -0800 (PST)
Received: (wp-smtpd smtp.wp.pl 15789 invoked from network); 9 Nov 2023 17:38:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1699547883; bh=FD4sUvfwvlc2rNXiE9SeJMK418brigy55nnKuP6JkpA=;
          h=From:To:Cc:Subject;
          b=L4/Glb6DzFdDL/V0tTNB20d/paj23Dme6O/5S6vMBeZ9Hx+/pDnMDBrvaFaiHVuAp
           JmZV0Q39gLY16ainGl0k22BA9DR//RYAqUZ4NuhVZrnkr82Q32ZbTYAXy+jae7GVKs
           q9R9EyqlTYPIRtxo1IsQnTsjWVJ0MexzqWDi0yPE=
Received: from 89-64-13-111.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.111])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 9 Nov 2023 17:38:03 +0100
Date:   Thu, 9 Nov 2023 17:38:02 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: rt2x00: correct wrong BBP register in RxDCOC
 calibration
Message-ID: <20231109163802.GA125222@wp.pl>
References: <TYAP286MB0315B13B89DF57B6B27BB854BCAFA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB0315B13B89DF57B6B27BB854BCAFA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: 9b2e24cb73712169f491c03dedcffe17
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UTPE]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 12:38:51PM +0800, Shiji Yang wrote:
> Refer to Mediatek vendor driver RxDCOC_Calibration() function, when
> performing gainfreeze calibration, we should write register 140
> instead of 141. This fix can reduce the total calibration time from
> 6 seconds to 1 second.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
