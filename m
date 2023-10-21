Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E17D1C46
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjJUJsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJUJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:48:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F3613E
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:48:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3BCC433C7;
        Sat, 21 Oct 2023 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697881715;
        bh=LWyKW1uK7K8s4xmPcXxHy2ZlSq7/79IXRHSU/lV9Cpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Btu82OJjszJ0E63UkiKXGBlda/QUAuCXb4Fi/Af0AZj9mWjpB5gjxjfxGDOC3EgNz
         u6Fc17Zaq1WLuuFE//XcYxJWR0+0NeB9rZ9eJv2FfaDh0YN15gYMw7EEYrc1ZWmn8I
         15NIpJO2CKN/9gc2bckhrdn6veyKMETwxxzz+btA=
Date:   Sat, 21 Oct 2023 11:48:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Alignment should match open parenthesis
Message-ID: <2023102131-slacker-lily-28ff@gregkh>
References: <20231019213949.GA2922@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019213949.GA2922@ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:39:49PM -0700, Nandha Kumar Singaram wrote:
> Adhere to linux coding style. Reported by checkpatch.pl:
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> ---
>  drivers/staging/greybus/camera.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index cdbb42cd413b..405c8e78aa72 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
>  }
>  
>  static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> -		struct gb_camera_configure_streams_response *resp)
> +				      struct gb_camera_configure_streams_response *resp)
>  {
>  	unsigned int max_pkt_size = 0;
>  	unsigned int i;
> @@ -267,8 +267,7 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
>   * Validate the stream configuration response verifying padding is correctly
>   * set and the returned number of streams is supported
>   */
> -static const int gb_camera_configure_streams_validate_response(
> -		struct gb_camera *gcam,
> +static const int gb_camera_configure_streams_validate_response(struct gb_camera *gcam,

Why change this line?

It's fine, but then:

>  		struct gb_camera_configure_streams_response *resp,
>  		unsigned int nstreams)

These lines are not fixed up?

thanks,

greg k-h
