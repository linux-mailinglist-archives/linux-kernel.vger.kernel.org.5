Return-Path: <linux-kernel+bounces-55359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D484BBB8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0222F1C2241C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17EA8F7D;
	Tue,  6 Feb 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjw28Cd3"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52D6FAF;
	Tue,  6 Feb 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239837; cv=none; b=hQPHyufvX+ze2gE8QHWE9bSA2tpzoTIawjPPGKdbt+ErvhS0QMiY9Vnt/ZsoeQKOMnCdgY8XVf32Xs+2NwbkMcUaPU9sshvSuJGjBdCxBBiBED5rm3sKlB348BrMck+oPab59amsf/PFDUv8e/cCVFsm8ksJbTE/oUaZVRtlMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239837; c=relaxed/simple;
	bh=3Y7hcR+QmjRhNLB72PysPEra8NTlgzKJ0tZSdOlN64Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I95KBRbktTpmBBZvMwwDKPYwqsyV+3cNADciynrbskIubeV/MH3/jGkbejra4vesWwQlRrGS+LtxEs0mh06H0k4iosIKHHnUZSKtY1FoMbTePtMSGTguxV2i1fkFvxpuLXBLmU9HZ2H4DBhGrfh+LTNwV57UsK2pHO7pMIGj0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjw28Cd3; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59a8b9b327aso2405507eaf.2;
        Tue, 06 Feb 2024 09:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707239834; x=1707844634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lLyPWHcBxFlNAEbuIoGNpkP18K8vI24efZX/+cAmrcY=;
        b=bjw28Cd3CH9dClqtQK5W+I6hGxZxItCeeC955+AmT54Nl2JEn1hshuH+6yGZX5Iy8i
         iqonTqSqjMVNG8Kljk71un9mTTLQe2TRsgJtpj+V8joCJuK/RuJcfDlvGVjhR+wR3Myb
         mtNDuP2HnrVIFYzu4CrfMLzCkbEsG7crPGBQTYCKdOiTY2NiPg21dUjDEWXD31hUK+vA
         Cv/m1QEul8XdYY2B5yGDaAXCZAEfgzYFdusbdA5sfFPjpchNdlcwVaYEQv77cDb0LWQT
         n70E1tt3FqcUsWqbF3Q3JBkP3b0nin3EkLtFlOML7lGfLM+9G55nVWdgni//R5Jxvsxe
         QSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707239834; x=1707844634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLyPWHcBxFlNAEbuIoGNpkP18K8vI24efZX/+cAmrcY=;
        b=H6P37j2NUGxIIPZh58YuWWDZmOtBXCa2uoWntWq2aJNk1HEYXOCfl4rSSINY5MMXFg
         e5LxGWd7J2LylDxATTGNCbFTwnUKQYmInHzkGk+EuzVsgiyR+j6NPt5ay8rvGjSlUK3C
         N+Gr5nlhkL195YdCpYLTT93oJnblBOW9AlxDao7OHO3+d66a/iipPh5d/d0qHKknT/eZ
         BJ3uR9TfN1F38oejVrGZY9FRDP9ajFKHCO3wCnT1N+dVyLTrhvt5QSQYRJfi7S/u5hEc
         jPghSyD/MCPHjofCaUKg/hZ5+5QV+pqnvXTBB70kpP6BwJsXkz2VC0ESnHGszCw/EjZP
         uXhg==
X-Gm-Message-State: AOJu0YxAgz8FLLTXVDOF8I/aRyPU5WsLAMKzfcsz34Qj00YkNDkERQel
	3zhHE80moXKvuzl4j3V3grhAeZAexsL4nheBt0x691T9SFHjsdDT
X-Google-Smtp-Source: AGHT+IEaDihVqZYuQDIngt85S6vfVhoVACcZa6/uwypAJ4g8x010Aol6FDWim+lsC6GvKCTLIl43Lw==
X-Received: by 2002:a4a:3505:0:b0:59c:c37c:8ce2 with SMTP id l5-20020a4a3505000000b0059cc37c8ce2mr3620992ooa.6.1707239834492;
        Tue, 06 Feb 2024 09:17:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUZouSrN8QXgkdPEbn0tE9ioAvaLI9XYXjJnmNZqKEAkrYEKDdOfcOyjK4KY09Sdr4XYiddsG2B80rCkyDPEdM7r4ZOeLmk+V+XwNFuLEreUpziJaGORXJzepWh7DEzVZZ/4dnbyeF7FhDeU3hkqohWqN1EJZMWrodPNMytehjSBwAzBHkZwWPl5p8CHl7NudpUBXhtv9excQEvCJpu3TEjNht5ELYPdWbZhxU3iBfUZLShjq7zPiB8X1WkjuesCWjpdo3r+LkYptlLKYZnDH3KXBr5VhgbzzzZQ2Vry87ykKUap4cx1Xd7wyApYUUfEIR+eBLNlvcYzxdGE1LWKpqao34+1LNNy4uVq1dw1vzbPdHb2FiVuGhRs65PcNagq/SD2h1ihyP/oWk0Kpa4Z2EEDB2U/g==
Received: from neuromancer. ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id v30-20020a4a245e000000b0059a826dcf53sm382948oov.40.2024.02.06.09.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:17:14 -0800 (PST)
Message-ID: <65c2699a.4a0a0220.5cd9c.2ff7@mx.google.com>
X-Google-Original-Message-ID: <ZcJpmMjGNVDw1Avw@neuromancer.>
Date: Tue, 6 Feb 2024 11:17:12 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	linux-input@vger.kernel.org,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] Input: uinput - Add UI_SET_UNIQ ioctl handler
References: <20191203173821.4u6uzxeaqnt3gyz3@pali>
 <20191203191112.GJ50317@dtor-ws>
 <20191205105206.slibwytrcteicx6y@pali>
 <CANFp7mXyaqoMDBs4m_Dfm9+4U88g9WoJVcV1g_4KM4xzFhiGXQ@mail.gmail.com>
 <20191206091114.kh255jrmerruumnq@pali>
 <20191206174048.GQ50317@dtor-ws>
 <20191218110224.44vcgdxh3j4bn7rw@pali>
 <20191218112659.crabhqkbcnxd6fo6@pali>
 <20200322154734.mquwgzc63nzddiy5@pali>
 <CABBYNZ+E3knrqWpNDKfX9qQOrrh=VLUSQAgUB=kXgK7=jwgQ9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+E3knrqWpNDKfX9qQOrrh=VLUSQAgUB=kXgK7=jwgQ9w@mail.gmail.com>

On Mon, Jun 13, 2022 at 02:36:18PM -0700, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Sun, Mar 22, 2020 at 8:47 AM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Wednesday 18 December 2019 12:26:59 Pali Rohár wrote:
> > > On Wednesday 18 December 2019 12:02:24 Pali Rohár wrote:
> > > > On Friday 06 December 2019 09:40:48 Dmitry Torokhov wrote:
> > > > > On Fri, Dec 06, 2019 at 10:11:14AM +0100, Pali Rohár wrote:
> > > > > > On Thursday 05 December 2019 12:03:05 Abhishek Pandit-Subedi wrote:
> > > > > > > On Thu, Dec 5, 2019 at 2:52 AM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tuesday 03 December 2019 11:11:12 Dmitry Torokhov wrote:
> > > > > > > > > On Tue, Dec 03, 2019 at 06:38:21PM +0100, Pali Rohár wrote:
> > > > > > > > > > On Tuesday 03 December 2019 00:09:47 Pali Rohár wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Dmitry!
> > > > > > > > > >
> > > > > > > > > > I was looking again at those _IOW defines for ioctl calls and I have
> > > > > > > > > > another argument why not specify 'char *' in _IOW:
> > > > > > > > > >
> > > > > > > > > > All ioctls in _IOW() specify as a third macro argument type which is
> > > > > > > > > > passed as pointer to the third argument for ioctl() syscall.
> > > > > > > > > >
> > > > > > > > > > So e.g.:
> > > > > > > > > >
> > > > > > > > > >   #define EVIOCSCLOCKID _IOW('E', 0xa0, int)
> > > > > > > > > >
> > > > > > > > > > is called from userspace as:
> > > > > > > > > >
> > > > > > > > > >   int val;
> > > > > > > > > >   ioctl(fd, EVIOCSCLOCKID, &val);
> > > > > > > > > >
> > > > > > > > > > Or
> > > > > > > > > >
> > > > > > > > > >   #define EVIOCSMASK _IOW('E', 0x93, struct input_mask)
> > > > > > > > > >
> > > > > > > > > > is called as:
> > > > > > > > > >
> > > > > > > > > >   struct input_mask val;
> > > > > > > > > >   ioctl(fd, EVIOCSMASK, &val);
> > > > > > > > > >
> > > > > > > > > > So basically third argument for _IOW specify size of byte buffer passed
> > > > > > > > > > as third argument for ioctl(). In _IOW is not specified pointer to
> > > > > > > > > > struct input_mask, but struct input_mask itself.
> > > > > > > > > >
> > > > > > > > > > And in case you define
> > > > > > > > > >
> > > > > > > > > >   #define MY_NEW_IOCTL _IOW(UINPUT_IOCTL_BASE, 200, char*)
> > > > > > > > > >
> > > > > > > > > > then you by above usage you should pass data as:
> > > > > > > > > >
> > > > > > > > > >   char *val = "DATA";
> > > > > > > > > >   ioctl(fd, MY_NEW_IOCTL, &val);
> > > > > > > > > >
> > > > > > > > > > Which is not same as just:
> > > > > > > > > >
> > > > > > > > > >   ioctl(fd, MY_NEW_IOCTL, "DATA");
> > > > > > > > > >
> > > > > > > > > > As in former case you passed pointer to pointer to data and in later
> > > > > > > > > > case you passed only pointer to data.
> > > > > > > > > >
> > > > > > > > > > It just mean that UI_SET_PHYS is already defined inconsistently which is
> > > > > > > > > > also reason why compat ioctl for it was introduced.
> > > > > > > > >
> > > > > > > > > Yes, you are right. UI_SET_PHYS is messed up. I guess the question is
> > > > > > > > > what to do with all of this...
> > > > > > > > >
> > > > > > > > > Maybe we should define
> > > > > > > > >
> > > > > > > > > #define UI_SET_PHYS_STR(len)  _IOC(_IOC_WRITE, UINPUT_IOCTL_BASE, 111, len)
> > > > > > > > > #define UI_SET_UNIQ_STR(len)  _IOC(_IOC_WRITE, UINPUT_IOCTL_BASE, 112, len)
> > > > > > > >
> > > > > > > > I'm not sure if this is ideal. Normally in C strings are nul-termined,
> > > > > > > > so functions/macros do not take buffer length.
> > > > > > > Except strncpy, strndup, snprintf, etc. all expect a buffer length. At
> > > > > >
> > > > > > This is something different as for these functions you pass buffer and
> > > > > > length of buffer which is used in write mode -- not for read mode.
> > > > > >
> > > > > > > the user to kernel boundary of ioctl, I think we should require size
> > > > > > > of the user buffer regardless of the data type.
> > > > > > >
> > > > > > > > _STR therefore in names looks inconsistent.
> > > > > > > The _STR suffix is odd (what to name UI_SET_PHYS_STR then??) but
> > > > > > > requiring the length seems to be common across various ioctls.
> > > > > > > * input.h requires a length when requesting the phys and uniq
> > > > > > > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/input.h#n138)
> > > > > > > * Same with HIDRAW when setting and getting features:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/hidraw.h#n40,
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/hidraw/hid-example.c#n88
> > > > > >
> > > > > > All these ioctls where is passed length are in opposite direction
> > > > > > (_IOC_READ) as our PHYS and UNIQ (_IOC_WRITE).
> > > > > >
> > > > > > I fully agree that when you need to read something from kernel
> > > > > > (_IOC_READ) and then writing it to userspace, you need to specify length
> > > > > > of userspace buffer. Exactly same as with userspace functions like
> > > > > > memcpy, snprintf, etc... as you pointed. Otherwise you get buffer
> > > > > > overflow as callee does not know length of buffer.
> > > > > >
> > > > > > But here we we have there quite different problem, we need to write
> > > > > > something to kernel from userspace (_IOC_WRITE) and we are passing
> > > > > > nul-term string. So in this case specifying size is not required as it
> > > > > > is implicitly specified as part of passed string.
> > > > >
> > > > > With the new IOCTL definitions it does not need to be a NULL-terminated
> > > > > string. It can be a buffer of characters with given length, and kernel
> > > > > will NULL-terminate as this it what it wants, not what the caller has to
> > > > > give.
> > > >
> > > > Hi Dmitry! I was thinking more about this problem and I will propose
> > > > alternative solution, but first with details...
> > > >
> > > > I think that we should use NULL terminated strings. Or better disallow
> > > > NULL byte inside string. Reason: all userspace application expects that
> > > > input device name would be NULL terminated which implies that in the
> > > > middle of name cannot be NULL byte.
> > > >
> > > > So this must apply also for new PHYS / UNIQ ioctl API. If we want in our
> > > > ioctl API to use buffer + size (with upper bound limit for size) instead
> > > > of passing NULL term string (with upper bound limit for string size)
> > > > then kernel have to add a leading NULL byte to string, plus check that
> > > > in the buffer there is no NULL byte. I guess this a very little
> > > > complicate code, but nothing which is problematic.
> > > >
> > > > And on the userspace part. Now when userspace want to pass constant
> > > > string for device name, it just call
> > > >
> > > >   ioctl(fd, UI_SET_PHYS, "my name of device");
> > > >
> > > > After adding a new ioctl with buffer + size API, userspace would have to
> > > > call:
> > > >
> > > >   ioctl(fd, UI_SET_PHYS_STR(strlen("my name of device")), "my name of device");
> > > >
> > > > which looks strange, so programmers would had to move device name into
> > > > new variable:
> > > >
> > > >   const char *name = "my name of device";
> > > >   ioctl(fd, UI_SET_PHYS_STR(strlen(name)), name);
> > > >
> > > > For me the old ioctl API looks easier to use (no need for strlen() or
> > > > extra variable), but this is just my preference of usage -- as it is
> > > > simpler for me. Maybe you would have different opinion...
> > > >
> > > > And now question: Why we have uinput_compat_ioctl()? It is there only
> > > > because size part of IOCTL number is different on 32bit and 64bit
> > > > systems. As we know size part of UI_SET_PHYS is wrong and does not make
> > > > sense...
> > > >
> > > > Would not it be better to change size of UI_SET_PHYS to just zero and
> > > > then when matching ioctl number just ignore size for this UI_SET_PHYS
> > > > ioctl? Same for UI_BEGIN_FF_UPLOAD_COMPAT and UI_END_FF_UPLOAD_COMPAT
> > > > added in: https://git.kernel.org/tip/tip/c/7c7da40
> > > >
> > > > And we would not have to deal with uinput_compat_ioctl() at all.
> > >
> > > Below is example how change for removing UI_SET_PHYS_COMPAT may look
> > > like. As header file is not changed and UI_SET_PHYS accepts any size
> > > argument, it therefore accept also 32bit and 64bit integer. So no
> > > existing 32bit applications which use UI_SET_PHYS on 64bit kernel would
> > > not be broken...
> > >
> > > Is not this better change then introducing a new UI_SET_PHYS_STR ioctl
> > > number? Because introduction of new IOCTL number has one big
> > > disadvantage: Userspace applications needs to support fallback to old
> > > number as older versions of kernels would be in use for a long time. And
> > > because kernel does not have to remove old IOCTL number for backward
> > > compatibility there is basically no need for userspace application to
> > > user new UI_SET_PHYS_STR IOCTL number...
> >
> > Hello! I would like to remind this discussion as problem around a new
> > UI_SET_UNIQ ioctl is not solved yet and uniq property is really useful
> > for e.g. bluetooth (uinput) devices.
> >
> > Dmitry, when you have a time, could you please look at this discussion
> > and decide how to go ahead?
> 
> Have we decided not to move further with these changes? I actually
> have a bug in BlueZ related to it since right now we are inconsistent
> with respect to how we handle uhid vs uinput:
> 
> https://github.com/bluez/bluez/issues/352
> 
> > > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> > > index fd253781b..b645210d5 100644
> > > --- a/drivers/input/misc/uinput.c
> > > +++ b/drivers/input/misc/uinput.c
> > > @@ -915,22 +915,6 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
> > >               retval = uinput_set_bit(arg, propbit, INPUT_PROP_MAX);
> > >               goto out;
> > >
> > > -     case UI_SET_PHYS:
> > > -             if (udev->state == UIST_CREATED) {
> > > -                     retval = -EINVAL;
> > > -                     goto out;
> > > -             }
> > > -
> > > -             phys = strndup_user(p, 1024);
> > > -             if (IS_ERR(phys)) {
> > > -                     retval = PTR_ERR(phys);
> > > -                     goto out;
> > > -             }
> > > -
> > > -             kfree(udev->dev->phys);
> > > -             udev->dev->phys = phys;
> > > -             goto out;
> > > -
> > >       case UI_BEGIN_FF_UPLOAD:
> > >               retval = uinput_ff_upload_from_user(p, &ff_up);
> > >               if (retval)
> > > @@ -1023,6 +1007,22 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
> > >       case UI_ABS_SETUP & ~IOCSIZE_MASK:
> > >               retval = uinput_abs_setup(udev, p, size);
> > >               goto out;
> > > +
> > > +     case UI_SET_PHYS & ~IOCSIZE_MASK:
> > > +             if (udev->state == UIST_CREATED) {
> > > +                     retval = -EINVAL;
> > > +                     goto out;
> > > +             }
> > > +
> > > +             phys = strndup_user(p, 1024);
> > > +             if (IS_ERR(phys)) {
> > > +                     retval = PTR_ERR(phys);
> > > +                     goto out;
> > > +             }
> > > +
> > > +             kfree(udev->dev->phys);
> > > +             udev->dev->phys = phys;
> > > +             goto out;
> > >       }
> > >
> > >       retval = -EINVAL;
> > > @@ -1042,8 +1042,6 @@ static long uinput_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > >   * These IOCTLs change their size and thus their numbers between
> > >   * 32 and 64 bits.
> > >   */
> > > -#define UI_SET_PHYS_COMPAT           \
> > > -     _IOW(UINPUT_IOCTL_BASE, 108, compat_uptr_t)
> > >  #define UI_BEGIN_FF_UPLOAD_COMPAT    \
> > >       _IOWR(UINPUT_IOCTL_BASE, 200, struct uinput_ff_upload_compat)
> > >  #define UI_END_FF_UPLOAD_COMPAT              \
> > > @@ -1053,9 +1051,6 @@ static long uinput_compat_ioctl(struct file *file,
> > >                               unsigned int cmd, unsigned long arg)
> > >  {
> > >       switch (cmd) {
> > > -     case UI_SET_PHYS_COMPAT:
> > > -             cmd = UI_SET_PHYS;
> > > -             break;
> > >       case UI_BEGIN_FF_UPLOAD_COMPAT:
> > >               cmd = UI_BEGIN_FF_UPLOAD;
> > >               break;
> > > diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
> > > index c9e677e3a..6bda2a142 100644
> > > --- a/include/uapi/linux/uinput.h
> > > +++ b/include/uapi/linux/uinput.h
> > > @@ -142,6 +142,8 @@ struct uinput_abs_setup {
> > >  #define UI_SET_LEDBIT                _IOW(UINPUT_IOCTL_BASE, 105, int)
> > >  #define UI_SET_SNDBIT                _IOW(UINPUT_IOCTL_BASE, 106, int)
> > >  #define UI_SET_FFBIT         _IOW(UINPUT_IOCTL_BASE, 107, int)
> > > +/* Argument is nul-term string and for backward compatibility is there
> > > + * specified char*, but size argument (char *) is ignored by this ioctl */
> > >  #define UI_SET_PHYS          _IOW(UINPUT_IOCTL_BASE, 108, char*)
> > >  #define UI_SET_SWBIT         _IOW(UINPUT_IOCTL_BASE, 109, int)
> > >  #define UI_SET_PROPBIT               _IOW(UINPUT_IOCTL_BASE, 110, int)
> > >
> > >
> >
> > --
> > Pali Rohár
> > pali.rohar@gmail.com
> 
> 
> 
> -- 
> Luiz Augusto von Dentz

Hate to dig a post up from the dead, but I have a use case for this
ioctl just like the bluez team and would like to see if I can help
push it across the finish line.

Unlike this patch series mimicking what is done with the UI_SET_PHYS
ioctl, I'd like to simply have a fixed size of 64 characters allowed.
I'm choosing 64 because that's the same size as the uniq value in the
hid_device struct (specifically it's set as `char uniq[64]`).

Would such a specific limit be acceptable, and if so it shouldn't have
all the messy compatible bits like the proposed method here, would it?

Thank you,
Chris

