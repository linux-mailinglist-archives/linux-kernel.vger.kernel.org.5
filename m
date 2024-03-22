Return-Path: <linux-kernel+bounces-111270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8468869ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DDA2879D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB139860;
	Fri, 22 Mar 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1+9IeIN"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070238DDD;
	Fri, 22 Mar 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101978; cv=none; b=WcHheIIiA3W+qIwxoyPyCvE/3fgaZgiYSf8p2qv2OOBqyi/qvN5wsjUat/srP+0myk21CNJIgNb5oZZbOFVrMZYzNLJEdtuyskXnoPr/yBF6szx0QlAnRRqrUkyh8pjZWnSu6bVjNgjefz7+pRGHEyuoWMS1WouSsjzqh4wDFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101978; c=relaxed/simple;
	bh=5/NL82xbhXJXzVmjOA8LpsdsUhb2KNvVldKtcBx1awA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSQRQEND/+llMEyvDu5eYiYqA9e3PeYaUbJa1HlsmrBvYRiTbb2ENkmoqDfz8ASUIgXbZTmgprwNRK1J2nl6rXrYrj7Vfof3fPjpoxrQaax4OqfcByy7fDwMdVtdBt0vFDLQuwS9zVDWj2NENdwMFyNHOp4OwQnuQ/EwRGafSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1+9IeIN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ec7e1d542so1132470f8f.1;
        Fri, 22 Mar 2024 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711101975; x=1711706775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mGuiXVSynmMWoae/KrxhE4H+cmeMuMWjiHJAs954wAM=;
        b=U1+9IeING6gvfy3BJet1PjVyuNAd3W6fc+hxjbIVE1kMkBfN7WK16PJdZe6OZDliCu
         XsA9gCjdpN5CwlyQZlH5vFckP2pySGhNItq2vmB2i/J8OUpTCVZ3L1zGdCVgcOatdWVB
         VH1PXn40HLibJFmrbi+3TfxdPj+2W4ErDvzt6WUqXLLgwtpSOhDR19mVQ7DHIiebT0T3
         LE5Q6k3kHVm9MXzCtEfUQxAvE7mWwNdD+NOf4Agd1TQOGscMYL6SuG7yyg8huaZNIgM1
         +tr7tydICkbhk5ief6X9Kjln67JtQ9eVTEmVuzxf4+lVnFdUVBnQ6xGD+jibK5WAeFRv
         JarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711101975; x=1711706775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGuiXVSynmMWoae/KrxhE4H+cmeMuMWjiHJAs954wAM=;
        b=JKDi5cESXUeD8PJfdDJErKjM9dw9XYQF4GuwF6cbDSjMgZCEt8Pc5spMSfi4ii0WHf
         6xlhF3C9ms2hqpgsAbqh81qKDkrSt4wuE7+DMXWWN9bAFMiocEz4rUJan/E1VdT7kNbw
         gxx1u5eqnPZ4qwKxn8TbVLW8o8hh6dk/9CmpCnhy41U5NbAVV0EubTE9B51HIYBawLk0
         Wh/Dwt7xGh0RRNBIJVCgnSJuZWsfCJ/zF7RQBnZX4K0yfEvWG+42/GPFgxZZ6CDYvf2q
         D+0N1/ndz/35eTC87vgOlI3CV51GQ3p4GxdFdiAo4Q8FDAEzYfyB4fJzpVra+zCe2N0T
         GDDw==
X-Forwarded-Encrypted: i=1; AJvYcCUynO6SdIIcgHGwATJCd3t4n/5rtKf5lxWGvW6MOfqVGjrd+Ak3tkMYYHElIXIRz0Mbsie6QXkdSylLeE8LH/DkMynpqKkcWhnnrqmHFEq6sbRkkAeAXq8GYmd5na1tdqFWPE7s6d+dxT4=
X-Gm-Message-State: AOJu0YxBMxItj/z4Q80TQwJ6R6ouO7JBuGLcMwyDGZ4OYmqEbevvVaAM
	pgdETSMsWkY99TsjSnmjQlaTkP7waDBMnEjTrNGOXkTgWqmtFpJ3
X-Google-Smtp-Source: AGHT+IE4T2+x5qCpZ+WQ1UyTLSWtI13OzmXLebn2fGx+8ntf6GqeFkTqSsgVaPFUPktuZW8VPEJ3Xw==
X-Received: by 2002:a05:6000:4008:b0:33e:7f65:bb7b with SMTP id cp8-20020a056000400800b0033e7f65bb7bmr1686415wrb.5.1711101975150;
        Fri, 22 Mar 2024 03:06:15 -0700 (PDT)
Received: from fedora ([94.73.33.46])
        by smtp.gmail.com with ESMTPSA id co20-20020a0560000a1400b00341b3c6c88dsm1538632wrb.15.2024.03.22.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:06:14 -0700 (PDT)
Date: Fri, 22 Mar 2024 11:06:13 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: uclogic: Store firmware name in params
Message-ID: <Zf1YFQh-S6_21Hwx@fedora>
References: <20240321144553.262409-1-jose.exposito89@gmail.com>
 <20240321144553.262409-2-jose.exposito89@gmail.com>
 <dadh7jtdpdf3iahcgxdaqadpc6k6gnaz6gatxycxpd4u2atl7a@2f4vzqwzt7n3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dadh7jtdpdf3iahcgxdaqadpc6k6gnaz6gatxycxpd4u2atl7a@2f4vzqwzt7n3>

Hi Benjamin,

Thanks a lot for the quick review :)

On Thu, Mar 21, 2024 at 04:01:06PM +0100, Benjamin Tissoires wrote:
> 
> Hi José,
> 
> On Mar 21 2024, José Expósito wrote:
> > A future patch will need to access the firmware name to expose it to
> > userspace via sysfs.
> > 
> > Store it in `uclogic_params->fw_name`.
> > 
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> >  drivers/hid/hid-uclogic-params.c | 14 +++++++-------
> >  drivers/hid/hid-uclogic-params.h |  5 +++++
> >  2 files changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
> > index 9859dad36495..79ec3eb80f84 100644
> > --- a/drivers/hid/hid-uclogic-params.c
> > +++ b/drivers/hid/hid-uclogic-params.c
> > @@ -121,6 +121,7 @@ void uclogic_params_hid_dbg(const struct hid_device *hdev,
> >  		params->invalid ? "true" : "false");
> >  	hid_dbg(hdev, ".desc_ptr = %p\n", params->desc_ptr);
> >  	hid_dbg(hdev, ".desc_size = %u\n", params->desc_size);
> > +	hid_dbg(hdev, ".fw_name = %s\n", params->fw_name);
> >  	hid_dbg(hdev, ".pen = {\n");
> >  	uclogic_params_pen_hid_dbg(hdev, &params->pen);
> >  	hid_dbg(hdev, "\t}\n");
> > @@ -652,6 +653,7 @@ void uclogic_params_cleanup(struct uclogic_params *params)
> >  	if (!params->invalid) {
> >  		size_t i;
> >  		kfree(params->desc_ptr);
> > +		kfree(params->fw_name);
> >  		uclogic_params_pen_cleanup(&params->pen);
> >  		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++)
> >  			uclogic_params_frame_cleanup(&params->frame_list[i]);
> > @@ -837,7 +839,6 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
> >  	/* The resulting parameters (noop) */
> >  	struct uclogic_params p = {0, };
> >  	static const char transition_ver[] = "HUION_T153_160607";
> > -	char *ver_ptr = NULL;
> >  	const size_t ver_len = sizeof(transition_ver) + 1;
> >  	__u8 *params_ptr = NULL;
> >  	size_t params_len = 0;
> > @@ -870,14 +871,14 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
> >  	}
> >  
> >  	/* Try to get firmware version */
> > -	ver_ptr = kzalloc(ver_len, GFP_KERNEL);
> > -	if (ver_ptr == NULL) {
> > +	p.fw_name = kzalloc(ver_len, GFP_KERNEL);
> > +	if (!p.fw_name) {
> >  		rc = -ENOMEM;
> >  		goto cleanup;
> >  	}
> > -	rc = usb_string(udev, 201, ver_ptr, ver_len);
> > +	rc = usb_string(udev, 201, p.fw_name, ver_len);
> >  	if (rc == -EPIPE) {
> > -		*ver_ptr = '\0';
> > +		*p.fw_name = '\0';
> >  	} else if (rc < 0) {
> >  		hid_err(hdev,
> >  			"failed retrieving Huion firmware version: %d\n", rc);
> > @@ -885,7 +886,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
> >  	}
> >  
> >  	/* If this is a transition firmware */
> > -	if (strcmp(ver_ptr, transition_ver) == 0) {
> > +	if (strcmp(p.fw_name, transition_ver) == 0) {
> >  		hid_dbg(hdev,
> >  			"transition firmware detected, not probing pen v2 parameters\n");
> >  	} else {
> > @@ -1028,7 +1029,6 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
> >  	rc = 0;
> >  cleanup:
> >  	kfree(params_ptr);
> > -	kfree(ver_ptr);
> >  	uclogic_params_cleanup(&p);
> >  	return rc;
> >  }
> > diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
> > index d6ffadb2f601..412c916770f5 100644
> > --- a/drivers/hid/hid-uclogic-params.h
> > +++ b/drivers/hid/hid-uclogic-params.h
> > @@ -232,6 +232,11 @@ struct uclogic_params {
> >  	 * List of event hooks.
> >  	 */
> >  	struct uclogic_raw_event_hook *event_hooks;
> > +	/*
> > +	 * Firmware name, exposed to userspace via sysfs as it is used to
> > +	 * identify the tablet.
> > +	 */
> > +	char *fw_name;
> 
> I can't remember if this was on the table or not, but any reasons to not
> use hid->uniq[64] field instead of a custom sysfs?
> If there is already a value, we could just append the firmware version
> with a colon (:) separator.
> 
> The main reason would be to not export a new sysfs specifically for this
> driver, but it would also allow HID-BPF to have access to the value and
> thus allow to detect if the device works with the given bpf program.

That's a very good point.

I tested with some tablets and for HUION, the uniq field is empty.
Other vendors just put garbage there. In fact, we override it in
tablets with battery to avoid a crash [1].

So, it'll be fine to just override the garbage in that field with
an actual unique ID. Sent v2 with the sugested change [2].

Thanks,
Jose

[1] https://github.com/JoseExposito/linux/commit/9845a1304a06805c3193c58283ca428c32c14fa7#diff-b3e9836cea703e50e8febb1f09b86f92833200e7bda4c9c1ea5a1d8b569b01dbR1257-R1262
[2] https://lore.kernel.org/linux-input/20240322100210.107152-1-jose.exposito89@gmail.com/T/

> Cheers,
> Benjamin
> 
> >  };
> >  
> >  /* Driver data */
> > -- 
> > 2.44.0
> > 

