Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6776753303
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjGNHT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjGNHTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:19:51 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E21C530EF;
        Fri, 14 Jul 2023 00:19:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BC6E380A8;
        Fri, 14 Jul 2023 07:19:36 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:19:35 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/3] PM / wakeirq: drop unused enable helpers
Message-ID: <20230714071935.GA5194@atomide.com>
References: <20230713145741.30390-1-johan+linaro@kernel.org>
 <20230713145741.30390-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713145741.30390-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan+linaro@kernel.org> [230713 15:01]:
> Drop the wake-irq enable and disable helpers which have not been used
> since commit bed570307ed7 ("PM / wakeirq: Fix dedicated wakeirq for
> drivers not using autosuspend").
> 
> Note that these functions are essentially just leftovers from the first
> iteration of the wake-irq implementation where device drivers were
> supposed to call these functions themselves instead of PM core (as
> is also indicated by the bogus kernel doc comments).

Agreed no need for these any longer:

Reviewed-by: Tony Lindgren <tony@atomide.com>

