Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2627CC4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbjJQNVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbjJQNU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:20:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE68FB;
        Tue, 17 Oct 2023 06:20:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50275C433C7;
        Tue, 17 Oct 2023 13:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697548857;
        bh=DEkqNmzds8Ci2deusV9ND8pFusPHgNOReVI/jawew0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ock2JMUfJwdoHyb/39iHGSKBLqXiz1VSRyQXb7dbPCxRFUudSIzbkzLcm1gZrDi9s
         +OPWx4xWe2WhwHh63Ajg9RmvchBzCxurREEF1nMcMvsaVUmrgkpYbFy6PHod1qzQT2
         v9krwUa9+xz6XJqVGms5qmzq3Owv5ZZVu4bFw1Wk=
Date:   Tue, 17 Oct 2023 15:20:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        ekangupt@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH v4 4/5] misc: fastrpc: Add support to save and restore
 interrupted
Message-ID: <2023101739-heftiness-reproach-ef96@gregkh>
References: <1697534799-5124-1-git-send-email-quic_ekangupt@quicinc.com>
 <1697534799-5124-5-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697534799-5124-5-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:56:38PM +0530, Ekansh Gupta wrote:
> For any remote call, driver sends a message to DSP using RPMSG
> framework. After message is sent, there is a wait on a completion
> object at driver which is completed when DSP response is received.
> 
> There is a possibility that a signal is received while waiting
> causing the wait function to return -ERESTARTSYS. In this case
> the context should be saved and it should get restored for the
> next invocation for the thread.
> 
> Adding changes to support saving and restoring of interrupted
> fastrpc contexts.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> Change-Id: Ia101acf7c1bf6018635536082bf7ea009093c948
> ---
> Changes in v2:
>   - Fixed missing definition
>   - Fixes compile time issue

You forgot to run checkpatch.pl :(
