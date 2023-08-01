Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD776B6B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjHAOEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjHAOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:04:10 -0400
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 07:04:09 PDT
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF01115;
        Tue,  1 Aug 2023 07:04:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 47F3D101480;
        Tue,  1 Aug 2023 13:46:09 +0000 (UTC)
Message-ID: <4362abd1-b4ed-fea3-3d9a-bff74ed85215@enpas.org>
Date:   Tue, 1 Aug 2023 22:46:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] can: can327: remove casts from tty->disc_data
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
References: <20230801062237.2687-1-jirislaby@kernel.org>
 <20230801062237.2687-2-jirislaby@kernel.org>
From:   Max Staudt <max@enpas.org>
In-Reply-To: <20230801062237.2687-2-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 15:22, Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Thanks for spotting this!

Reviewed-by: Max Staudt <max@enpas.org>

