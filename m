Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09A880518E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376591AbjLELGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbjLELGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:06:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648E3122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:06:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16B5C433C7;
        Tue,  5 Dec 2023 11:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701774397;
        bh=rgJUwJ6GqxS/UtDw9jRVOllmpQab2HhQKk5CRvGD4NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YinYHhv+6oqy4AS4LYHcW4XAfudoECQpbKl8DmASdgq7tjk5FAu1qSLGG7EPgC8yg
         +HghCWl5DtDIrJJSKwUxlMtc5+WbeHNQDIy8IB1ZdP2qt+0+m3/I/4gdKkpL2cMoh7
         XbNlAAUv7/AiKeT+8XCRUo0taWr6T7dLzcpH/151gKrKFClEz3MZt93xsBbTkKxNNz
         ofUqL+FbylkjHC2s15WxU3ojQ5tHSjhPyEW5QfIV6jHlkYU9erT66RZ0GzJeTGaFBq
         Qbt7pvb7vzdUMdQxE2nmyokY6HQtvEjiJA0hpzSEwD1uhAyzQCrFVGw2H1Pb75znqO
         VPgRxmUdYHeVA==
Date:   Tue, 5 Dec 2023 12:06:33 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Hao Ge <gehao@kylinos.cn>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gehao618@163.com
Subject: Re: [PATCH] fs/namei: Don't update atime when some errors occur in
 get_link
Message-ID: <20231205-endstadium-teich-d8d0bc900e08@brauner>
References: <20231205071733.334474-1-gehao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205071733.334474-1-gehao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:17:33PM +0800, Hao Ge wrote:
> Perhaps we have some errors occur(like security),then we don't update
> atime,because we didn't actually access it
> 
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---

We didn't follow the link but we accessed it. I guess it's not completey
clear what's correct here so I'd just leave it as is.
