Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA5179761C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbjIGQBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbjIGP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:59:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8342A4481
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:48:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D352C4339A;
        Thu,  7 Sep 2023 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694100691;
        bh=76rEwfE/uTJS8ezcSl7+Wi3KuWBqHArCGxvgwyT7MEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRJ2pEom4OLSlDgiZnthU1HnTzpGSYXMHsgk2WtPSuO1ZGspi0pf2HMsPMv6BpmTo
         +3cutUabz0foPK3TwOkE0fplhrEY9seCaRtJejmBEdDJ9+vX3wCmGYdINRQs6OWNeW
         CNiNezaeXHXsKjr/wz6+Ybcw2+wKqfG/gj2fTess9yB8XeXN8HHL+u0HrG9T+5kksx
         G+LvWEQBPBb+nobha+ZqDSLnmqHy3U/3ZB0gi3vhq5RtCWgcgdkMDAqyMUouuzGEaV
         CTY7D1f0cIRQBl+mNDuSudE+IRvYo5N8tGIGie9uGuH73bB+vmlYKO4uv/GeS2g7SL
         w0eaw79B2mY6Q==
Date:   Thu, 7 Sep 2023 17:31:26 +0200
From:   Simon Horman <horms@kernel.org>
To:     Petr Oros <poros@redhat.com>
Cc:     netdev@vger.kernel.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        mschmidt@redhat.com, ivecera@redhat.com, ahmed.zaki@intel.com
Subject: Re: [PATCH net v2 1/2] iavf: add iavf_schedule_aq_request() helper
Message-ID: <20230907153126.GI434333@kernel.org>
References: <20230907150251.224931-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907150251.224931-1-poros@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 05:02:50PM +0200, Petr Oros wrote:
> Add helper for set iavf aq request AVF_FLAG_AQ_* and immediately
> schedule watchdog_task. Helper will be used in cases where it is
> necessary to run aq requests asap
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

