Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8927DCB12
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjJaKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjJaKoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:44:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFE083
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:44:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6C7C433C7;
        Tue, 31 Oct 2023 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698749062;
        bh=SawDb3Br63XTC/jdH0M9reH2F8gv8G87HRcLDKod6iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wMoo4qBs4TItTWCUSjNwcpS54mSu+vPvL1lQCpGujWbAFSqvE1ZZwORlI2gOpqJIj
         IyaP/03LbbjepUCKxyFwu52zv40jA6bC5skgCpOyP6lZLgKAzo4DloDapXT31jF6ll
         v2OFSJqM02gurFNMF5cywW4MRhgK2VnZ4OqZhj5A=
Date:   Tue, 31 Oct 2023 11:44:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tingwei Zhang <quic_tingweiz@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>
Subject: Re: How to pass software configuration to driver built as module in
 boot up phase
Message-ID: <2023103137-dowry-passover-c285@gregkh>
References: <1c001c6f-9902-4803-9406-39e3325422bf@quicinc.com>
 <2023103021-revolving-clapper-632d@gregkh>
 <c244eae0-d3d8-414b-8d1f-c902bd46bd61@quicinc.com>
 <2023103108-guacamole-neurotic-f59b@gregkh>
 <b97123bd-7acc-43a7-aff4-e1696511ba05@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b97123bd-7acc-43a7-aff4-e1696511ba05@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 06:01:44PM +0800, Tingwei Zhang wrote:
> > Why do you need this before init?  Specific reasons please.
> > 
> There are some case that some driver broke Kernel in development phase and
> those bad driver could cause device crash in very early boot up phase.

Then work on that in the development phase of your system, don't make it
a requirement for us for this.

thanks,

greg k-h
