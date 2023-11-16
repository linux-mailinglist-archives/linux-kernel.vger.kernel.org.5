Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD5B7EE642
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjKPR5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKPR5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:57:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A04A189
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:57:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABEEC433C7;
        Thu, 16 Nov 2023 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700157448;
        bh=079Pe3XGihXMQHu0ceh9H6g0JWvnDy8gtyhx9MMkQNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvkSz397Sn+qS6t4bocQTXP8ivxDxbDs8N5vHG64NgRh0S91nKa8456WVf+EXFJkU
         OBxWj0fuTlrwoSrYAiuXflr+ZQYCTx86ss4V3lhVPYJe5yqSc5Amzx1c/RP6NbiaWr
         kk6lhBYsgofdEUxCY8QyaOIS9VXSP2O5LH6zpUL/oJwdoglLfNNyY0Y46v9dXH1sh7
         oHoL2Ji404/Lw5DeAihBhYGTrXfG6g9XVYAl5BVPXXaunVDPljtMrU+aSIjc1MWqRK
         EQ+C56T69LcJXvu4qEI0ifULiP1kpI8I6J+UUseEqJdqc+L6CiOevvw9ZglJpaPBl6
         RhjOY/dTlEfLQ==
Date:   Thu, 16 Nov 2023 17:57:24 +0000
From:   Simon Horman <horms@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
        larry.chiu@realtek.com
Subject: Re: [PATCH net-next v11 00/13] Add Realtek automotive PCIe driver
Message-ID: <20231116175724.GF109951@vergenet.net>
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115133414.1221480-1-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 09:34:01PM +0800, Justin Lai wrote:
> This series includes adding realtek automotive ethernet driver 
> and adding rtase ethernet driver entry in MAINTAINERS file.
> 
> This ethernet device driver for the PCIe interface of 
> Realtek Automotive Ethernet Switch,applicable to 
> RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.

...

>  MAINTAINERS                                   |    7 +
>  drivers/net/ethernet/realtek/Kconfig          |   17 +
>  drivers/net/ethernet/realtek/Makefile         |    1 +
>  drivers/net/ethernet/realtek/rtase/Makefile   |   10 +
>  drivers/net/ethernet/realtek/rtase/rtase.h    |  353 +++
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 2542 +++++++++++++++++
>  drivers/net/ethernet/realtek/rtase/tt.c       | 2542 +++++++++++++++++
>  drivers/net/ethernet/realtek/rtase/tt.h       |  353 +++

Hi Justin,

Unless I am mistaken, by the end of this patch set tt.c is identical to
rtase_main.c, and tt.h is identical to rtase.h.

If so, why?

$ cd drivers/net/ethernet/realtek/rtase
$ sha1sum *.[ch] | sort
9762c7f0fc1acb214d1705905495fad6b902a3c8  rtase.h
9762c7f0fc1acb214d1705905495fad6b902a3c8  tt.h
ccfe889f5ae3b6ecfa0dfba91d30fd7beffd4291  rtase_main.c
ccfe889f5ae3b6ecfa0dfba91d30fd7beffd4291  tt.c

