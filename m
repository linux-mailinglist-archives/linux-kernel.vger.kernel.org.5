Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AFC7CA7FF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjJPMbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPMbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:31:41 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC089F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:31:39 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a8628e54d4so10681437b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697459499; x=1698064299; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ol9AcKb3GX58mmT6rVA5SYZFPR6grqwmzcycicwyPPk=;
        b=Lq/PzcVN3q0xi8JIGC530Y+cSe5NDqDXG33X0gNTLpU8OzXkJ7atL9lWWu7a/WgdIb
         ttQQpmv0nrmYp7fo/AEq0aJIBztkhiIl78pu5UlXSNRq/oPhVUirYKNlIGT+7+S+HHZ9
         pzHb1JYJ9v6YnMyxj8mpN9ocLcF2+jY5PGex/0LYHv5ipjG9XPE2S+wW6qe92lAOODuq
         XcwdDprPFC4HJFM8GLR7L3Yre9Qqp/FcfDEB16pTskvL4rnXYWZP1chp4Kkb2SUfPWb0
         4xtkOICpzleFrgmvLIeONXQvn5KJHgJtJFluWXKNIxFKHsBAfeQ4N6SPBbyKa4iKaQx+
         L0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697459499; x=1698064299;
        h=content-disposition:mime-version:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol9AcKb3GX58mmT6rVA5SYZFPR6grqwmzcycicwyPPk=;
        b=czTQb05IHrAgWxYglEpn6R1NPAun3zshREWtFGP1gDM/6CdPbm0zDtP8IT2BYO8K6V
         afhp4i/4kCgv/YIOkrv1bmJFmEYlpvCKu3Pdrsfzg+hu/txDJVabuE+X7P4mjwwxTiar
         E9qBHbq4w/OKHJWcH4pa2HaOGC4PCK9uY5yOdar5ZHd8Z/mnX330vmAau2FZi/KDX1Mx
         EMIeRl058XzZcnmRSW69zSEwv4kBNT1A65zxkYc5NtQXBVvvcDb470SMJ5xn9tMJ23bu
         cghyRxGBiFn1VcrXBU9wA22s3nA+DsDQYMjMem/lKAhpc9TWM24dxXgoV65cSKpdwL57
         nhHQ==
X-Gm-Message-State: AOJu0YwMFyqHRD0lFSjaatPTYm07tGnbEq7lflqAAxvOzJrPCTy7z6lV
        +u914qKXcF7zhqeG4wowB84=
X-Google-Smtp-Source: AGHT+IHAkIvH6aLmMXJ9DfqSroIpzcvIYfAOGHv3Z62aYL0umgenB9+wlH7CqZMya6P4M8PWIGcRvg==
X-Received: by 2002:a05:690c:dd5:b0:5a7:dad3:cd21 with SMTP id db21-20020a05690c0dd500b005a7dad3cd21mr5252395ywb.10.1697459498905;
        Mon, 16 Oct 2023 05:31:38 -0700 (PDT)
Received: from gilbert-PC ([105.112.31.148])
        by smtp.gmail.com with ESMTPSA id l184-20020a0dc9c1000000b005707fb5110bsm2202348ywd.58.2023.10.16.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:31:31 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:31:20 +0100
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <ZS0tGLOJxUztxbKj@gilbert-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_SUBJECT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org  
Bcc: 
Subject: Re: [PATCH] staging: emxx_udc: Remove unnecessary parentheses around
 condition tests
Reply-To: 
In-Reply-To: <6b60ed7-9d97-2071-44f8-83b173191ed@inria.fr>

On Mon, Oct 16, 2023 at 02:15:06PM +0200, Julia Lawall wrote:
> 
> 
> On Mon, 16 Oct 2023, Gilbert Adikankwu wrote:
> 
> > Fix 47 warnings detected by checkpatch.pl about unnecessary parenthesis
> > around condition tests.
> 
> If you need to make any changes to the patch, there is no need to give the
> count of the changes.  It doesn't matter if it's 47, 46, 35, etc.
> 
> julia
>
Hi Julia, 

I added the number because I saw I similar commit on the logs that did
so. (commit b83970f23f36f0e2968872140e69f68118d82fe3)
> >
> > Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
> > ---
> >  drivers/staging/emxx_udc/emxx_udc.c | 72 ++++++++++++++---------------
> >  1 file changed, 36 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> > index eb63daaca702..e8ddd691b788 100644
> > --- a/drivers/staging/emxx_udc/emxx_udc.c
> > +++ b/drivers/staging/emxx_udc/emxx_udc.c
> > @@ -149,8 +149,8 @@ static void _nbu2ss_ep0_complete(struct usb_ep *_ep, struct usb_request *_req)
> >  			/* SET_FEATURE */
> >  			recipient = (u8)(p_ctrl->bRequestType & USB_RECIP_MASK);
> >  			selector  = le16_to_cpu(p_ctrl->wValue);
> > -			if ((recipient == USB_RECIP_DEVICE) &&
> > -			    (selector == USB_DEVICE_TEST_MODE)) {
> > +			if (recipient == USB_RECIP_DEVICE &&
> > +			    selector == USB_DEVICE_TEST_MODE) {
> >  				wIndex = le16_to_cpu(p_ctrl->wIndex);
> >  				test_mode = (u32)(wIndex >> 8);
> >  				_nbu2ss_set_test_mode(udc, test_mode);
> > @@ -287,7 +287,7 @@ static int _nbu2ss_epn_exit(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
> >  	u32		num;
> >  	u32		data;
> >
> > -	if ((ep->epnum == 0) || (udc->vbus_active == 0))
> > +	if (ep->epnum == 0 || udc->vbus_active == 0)
> >  		return	-EINVAL;
> >
> >  	num = ep->epnum - 1;
> > @@ -336,7 +336,7 @@ static void _nbu2ss_ep_dma_init(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
> >  	u32		data;
> >
> >  	data = _nbu2ss_readl(&udc->p_regs->USBSSCONF);
> > -	if (((ep->epnum == 0) || (data & (1 << ep->epnum)) == 0))
> > +	if (ep->epnum == 0 || (data & (1 << ep->epnum)) == 0)
> >  		return;		/* Not Support DMA */
> >
> >  	num = ep->epnum - 1;
> > @@ -380,7 +380,7 @@ static void _nbu2ss_ep_dma_exit(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
> >  		return;		/* VBUS OFF */
> >
> >  	data = _nbu2ss_readl(&preg->USBSSCONF);
> > -	if ((ep->epnum == 0) || ((data & (1 << ep->epnum)) == 0))
> > +	if (ep->epnum == 0 || (data & (1 << ep->epnum)) == 0)
> >  		return;		/* Not Support DMA */
> >
> >  	num = ep->epnum - 1;
> > @@ -560,7 +560,7 @@ static int ep0_out_overbytes(struct nbu2ss_udc *udc, u8 *p_buf, u32 length)
> >  	union usb_reg_access  temp_32;
> >  	union usb_reg_access  *p_buf_32 = (union usb_reg_access *)p_buf;
> >
> > -	if ((length > 0) && (length < sizeof(u32))) {
> > +	if (length > 0 && length < sizeof(u32)) {
> >  		temp_32.dw = _nbu2ss_readl(&udc->p_regs->EP0_READ);
> >  		for (i = 0 ; i < length ; i++)
> >  			p_buf_32->byte.DATA[i] = temp_32.byte.DATA[i];
> > @@ -608,7 +608,7 @@ static int ep0_in_overbytes(struct nbu2ss_udc *udc,
> >  	union usb_reg_access  temp_32;
> >  	union usb_reg_access  *p_buf_32 = (union usb_reg_access *)p_buf;
> >
> > -	if ((i_remain_size > 0) && (i_remain_size < sizeof(u32))) {
> > +	if (i_remain_size > 0 && i_remain_size < sizeof(u32)) {
> >  		for (i = 0 ; i < i_remain_size ; i++)
> >  			temp_32.byte.DATA[i] = p_buf_32->byte.DATA[i];
> >  		_nbu2ss_ep_in_end(udc, 0, temp_32.dw, i_remain_size);
> > @@ -701,7 +701,7 @@ static int _nbu2ss_ep0_in_transfer(struct nbu2ss_udc *udc,
> >  		return result;
> >  	}
> >
> > -	if ((i_remain_size < sizeof(u32)) && (result != EP0_PACKETSIZE)) {
> > +	if (i_remain_size < sizeof(u32) && result != EP0_PACKETSIZE) {
> >  		p_buffer += result;
> >  		result += ep0_in_overbytes(udc, p_buffer, i_remain_size);
> >  		req->div_len = result;
> > @@ -738,7 +738,7 @@ static int _nbu2ss_ep0_out_transfer(struct nbu2ss_udc *udc,
> >  		req->req.actual += result;
> >  		i_recv_length -= result;
> >
> > -		if ((i_recv_length > 0) && (i_recv_length < sizeof(u32))) {
> > +		if (i_recv_length > 0 && i_recv_length < sizeof(u32)) {
> >  			p_buffer += result;
> >  			i_remain_size -= result;
> >
> > @@ -891,8 +891,8 @@ static int _nbu2ss_epn_out_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
> >
> >  	req->req.actual += result;
> >
> > -	if ((req->req.actual == req->req.length) ||
> > -	    ((req->req.actual % ep->ep.maxpacket) != 0)) {
> > +	if (req->req.actual == req->req.length ||
> > +	    (req->req.actual % ep->ep.maxpacket) != 0) {
> >  		result = 0;
> >  	}
> >
> > @@ -914,8 +914,8 @@ static int _nbu2ss_epn_out_data(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
> >
> >  	i_buf_size = min((req->req.length - req->req.actual), data_size);
> >
> > -	if ((ep->ep_type != USB_ENDPOINT_XFER_INT) && (req->req.dma != 0) &&
> > -	    (i_buf_size  >= sizeof(u32))) {
> > +	if (ep->ep_type != USB_ENDPOINT_XFER_INT && req->req.dma != 0 &&
> > +	    i_buf_size  >= sizeof(u32)) {
> >  		nret = _nbu2ss_out_dma(udc, req, num, i_buf_size);
> >  	} else {
> >  		i_buf_size = min_t(u32, i_buf_size, ep->ep.maxpacket);
> > @@ -954,8 +954,8 @@ static int _nbu2ss_epn_out_transfer(struct nbu2ss_udc *udc,
> >  			}
> >  		}
> >  	} else {
> > -		if ((req->req.actual == req->req.length) ||
> > -		    ((req->req.actual % ep->ep.maxpacket) != 0)) {
> > +		if (req->req.actual == req->req.length ||
> > +		    (req->req.actual % ep->ep.maxpacket) != 0) {
> >  			result = 0;
> >  		}
> >  	}
> > @@ -1106,8 +1106,8 @@ static int _nbu2ss_epn_in_data(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
> >
> >  	num = ep->epnum - 1;
> >
> > -	if ((ep->ep_type != USB_ENDPOINT_XFER_INT) && (req->req.dma != 0) &&
> > -	    (data_size >= sizeof(u32))) {
> > +	if (ep->ep_type != USB_ENDPOINT_XFER_INT && req->req.dma != 0 &&
> > +	    data_size >= sizeof(u32)) {
> >  		nret = _nbu2ss_in_dma(udc, ep, req, num, data_size);
> >  	} else {
> >  		data_size = min_t(u32, data_size, ep->ep.maxpacket);
> > @@ -1238,7 +1238,7 @@ static void _nbu2ss_endpoint_toggle_reset(struct nbu2ss_udc *udc, u8 ep_adrs)
> >  	u8		num;
> >  	u32		data;
> >
> > -	if ((ep_adrs == 0) || (ep_adrs == 0x80))
> > +	if (ep_adrs == 0 || ep_adrs == 0x80)
> >  		return;
> >
> >  	num = (ep_adrs & 0x7F) - 1;
> > @@ -1261,7 +1261,7 @@ static void _nbu2ss_set_endpoint_stall(struct nbu2ss_udc *udc,
> >  	struct nbu2ss_ep *ep;
> >  	struct fc_regs __iomem *preg = udc->p_regs;
> >
> > -	if ((ep_adrs == 0) || (ep_adrs == 0x80)) {
> > +	if (ep_adrs == 0 || ep_adrs == 0x80) {
> >  		if (bstall) {
> >  			/* Set STALL */
> >  			_nbu2ss_bitset(&preg->EP0_CONTROL, EP0_STL);
> > @@ -1392,8 +1392,8 @@ static inline int _nbu2ss_req_feature(struct nbu2ss_udc *udc, bool bset)
> >  	u8	ep_adrs;
> >  	int	result = -EOPNOTSUPP;
> >
> > -	if ((udc->ctrl.wLength != 0x0000) ||
> > -	    (direction != USB_DIR_OUT)) {
> > +	if (udc->ctrl.wLength != 0x0000 ||
> > +	    direction != USB_DIR_OUT) {
> >  		return -EINVAL;
> >  	}
> >
> > @@ -1480,7 +1480,7 @@ static int std_req_get_status(struct nbu2ss_udc *udc)
> >  	u8	ep_adrs;
> >  	int	result = -EINVAL;
> >
> > -	if ((udc->ctrl.wValue != 0x0000) || (direction != USB_DIR_IN))
> > +	if (udc->ctrl.wValue != 0x0000 || direction != USB_DIR_IN)
> >  		return result;
> >
> >  	length =
> > @@ -1542,9 +1542,9 @@ static int std_req_set_address(struct nbu2ss_udc *udc)
> >  	int		result = 0;
> >  	u32		wValue = le16_to_cpu(udc->ctrl.wValue);
> >
> > -	if ((udc->ctrl.bRequestType != 0x00)	||
> > -	    (udc->ctrl.wIndex != 0x0000)	||
> > -		(udc->ctrl.wLength != 0x0000)) {
> > +	if (udc->ctrl.bRequestType != 0x00	||
> > +	    udc->ctrl.wIndex != 0x0000		||
> > +		udc->ctrl.wLength != 0x0000) {
> >  		return -EINVAL;
> >  	}
> >
> > @@ -1564,9 +1564,9 @@ static int std_req_set_configuration(struct nbu2ss_udc *udc)
> >  {
> >  	u32 config_value = (u32)(le16_to_cpu(udc->ctrl.wValue) & 0x00ff);
> >
> > -	if ((udc->ctrl.wIndex != 0x0000)	||
> > -	    (udc->ctrl.wLength != 0x0000)	||
> > -		(udc->ctrl.bRequestType != 0x00)) {
> > +	if (udc->ctrl.wIndex != 0x0000	||
> > +	    udc->ctrl.wLength != 0x0000	||
> > +		udc->ctrl.bRequestType != 0x00) {
> >  		return -EINVAL;
> >  	}
> >
> > @@ -1838,8 +1838,8 @@ static void _nbu2ss_ep_done(struct nbu2ss_ep *ep,
> >  	}
> >
> >  #ifdef USE_DMA
> > -	if ((ep->direct == USB_DIR_OUT) && (ep->epnum > 0) &&
> > -	    (req->req.dma != 0))
> > +	if (ep->direct == USB_DIR_OUT && ep->epnum > 0 &&
> > +	    req->req.dma != 0)
> >  		_nbu2ss_dma_unmap_single(udc, ep, req, USB_DIR_OUT);
> >  #endif
> >
> > @@ -1931,7 +1931,7 @@ static inline void _nbu2ss_epn_in_dma_int(struct nbu2ss_udc *udc,
> >  		mpkt = ep->ep.maxpacket;
> >  		size = preq->actual % mpkt;
> >  		if (size > 0) {
> > -			if (((preq->actual & 0x03) == 0) && (size < mpkt))
> > +			if ((preq->actual & 0x03) == 0 && size < mpkt)
> >  				_nbu2ss_ep_in_end(udc, ep->epnum, 0, 0);
> >  		} else {
> >  			_nbu2ss_epn_in_int(udc, ep, req);
> > @@ -2428,8 +2428,8 @@ static int nbu2ss_ep_enable(struct usb_ep *_ep,
> >  	}
> >
> >  	ep_type = usb_endpoint_type(desc);
> > -	if ((ep_type == USB_ENDPOINT_XFER_CONTROL) ||
> > -	    (ep_type == USB_ENDPOINT_XFER_ISOC)) {
> > +	if (ep_type == USB_ENDPOINT_XFER_CONTROL ||
> > +	    ep_type == USB_ENDPOINT_XFER_ISOC) {
> >  		pr_err(" *** %s, bat bmAttributes\n", __func__);
> >  		return -EINVAL;
> >  	}
> > @@ -2438,7 +2438,7 @@ static int nbu2ss_ep_enable(struct usb_ep *_ep,
> >  	if (udc->vbus_active == 0)
> >  		return -ESHUTDOWN;
> >
> > -	if ((!udc->driver) || (udc->gadget.speed == USB_SPEED_UNKNOWN)) {
> > +	if (!udc->driver || udc->gadget.speed == USB_SPEED_UNKNOWN) {
> >  		dev_err(ep->udc->dev, " *** %s, udc !!\n", __func__);
> >  		return -ESHUTDOWN;
> >  	}
> > @@ -2603,8 +2603,8 @@ static int nbu2ss_ep_queue(struct usb_ep *_ep,
> >  		}
> >  	}
> >
> > -	if ((ep->epnum > 0) && (ep->direct == USB_DIR_OUT) &&
> > -	    (req->req.dma != 0))
> > +	if (ep->epnum > 0 && ep->direct == USB_DIR_OUT &&
> > +	    req->req.dma != 0)
> >  		_nbu2ss_dma_map_single(udc, ep, req, USB_DIR_OUT);
> >  #endif
> >
> > --
> > 2.34.1
> >
> >
> >
