Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA280CA1C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjLKMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343600AbjLKMks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:40:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361698E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:40:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEAFC433C9;
        Mon, 11 Dec 2023 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702298454;
        bh=ROmUd+olsD+OTnQvuY7AsKIIZPO+4MWpYfD8N5iPbxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wBqCxXOYNpBulZcmJMR1DC0+u8gOZ8zF8PsHHkH+vO6zic/ijVRgmtlfPmn8KXhS3
         UExzqkGl4Xj9j8055spMkESNoP8FtY0PaUXebUeu6PrvSgqg7dhiNx7G0J7bH5s+lI
         XdEgB8Gct0rZUfwGewFcwHQQZ3Kh3X1Z7u/Ja7Qs=
Date:   Mon, 11 Dec 2023 13:40:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 0/2] ASoC: qcom: Limit Digital gains on speaker
Message-ID: <2023121146-hunger-crane-7dee@gregkh>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
 <ZXbDY1iA_DQLIzqq@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXbDY1iA_DQLIzqq@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 09:08:03AM +0100, Johan Hovold wrote:
> Hi Greg and Sasha,
> 
> On Mon, Dec 04, 2023 at 12:47:34PM +0000, srinivas.kandagatla@linaro.org wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > 
> > Limit the speaker digital gains to 0dB so that the users will not damage them.
> > Currently there is a limit in UCM, but this does not stop the user form
> > changing the digital gains from command line. So limit this in driver
> > which makes the speakers more safer without active speaker protection in
> > place.
> > 
> > Apart from this there is also a range check fix in snd_soc_limit_volume
> > to allow setting this limit correctly.
> > 
> > Tested on Lenovo X13s.
> > 
> > Srinivas Kandagatla (2):
> >   ASoC: ops: add correct range check for limiting volume
> >   ASoC: qcom: sc8280xp: Limit speaker digital volumes
> 
> These were unfortunately not marked for stable, but could you pick them
> up for 6.6?
> 
> The upstream commits are:
> 
> 	fb9ad2448508 ("ASoC: ops: add correct range check for limiting volume")
> 	716d4e5373e9 ("ASoC: qcom: sc8280xp: Limit speaker digital volumes")

Now queued up, thanks.

greg k-h
