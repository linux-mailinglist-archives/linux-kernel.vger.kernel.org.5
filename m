Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078ED7624BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGYVqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjGYVqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:46:50 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6072D1FEB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:46:49 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40540a8a3bbso45011cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690321608; x=1690926408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WeO3w5j/VGzkeBcsbTqL6Ugkx9JAZXSf5TVBk0qrsq4=;
        b=tXKSsTvnwnw2k5C+3o6AnY/skMQVI3yt6rb23ehFcACxX6CbXx78LYYA4dKrj1ZfEW
         WsFB0rhHpiO9n+Hb9BpbvKXtHlnj71KTgZWE5oa1kmerKQvlBy8vGxwNNVzlhXDunJqQ
         vCOHfmTWHRqRQ+jAm95xJj+4QLXk8xBBaeA8aiRL6nOC8RN6R/ABHTOm0dWcgG3qGHQx
         NIJwtp1LIgEAA1fcDQKsDXzgvjfa44D0dJzUVmxoDc2DG7IIHFgGkjcFgW0Qaa6VORyo
         faqPpttc4n1a2Myx+PdRdcSqzPgfRz43soPp0ar+yLyInyGfSE3ecFdvBZKu3IFVLlFc
         mE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690321608; x=1690926408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeO3w5j/VGzkeBcsbTqL6Ugkx9JAZXSf5TVBk0qrsq4=;
        b=kv1/+Mue0Od5uWR/7H7KMaqDtjlVYz/a3iERNW3Rotr9SZAxZCQGkqNXlQdDKqs456
         pE7WtxYg550VXr2R1c+nmG/9XOaOa9qfGN8+CLrsChGyye4RL9wKL/gbniqHFFoasx8X
         XY5yCC16gjYWGqwLr+AS2UgNoKReoAHIF6mbUR/4i5u+BQeEzfut6+kjjSYGXS26DtS6
         s+JhqlT3y1Lr7cJwfHC0f+EVBheCLfnk2jIHNpYpXzTFp8lCSJBolv2jlVsig8MwHJlL
         h7yqVhGgz9Oun1ZfSnXiMI3lm/eR0gEAsXuwMMBzfOReXDkGZb2d/mZ06iwsRpl13wIo
         uuRA==
X-Gm-Message-State: ABy/qLYZGhPRHoKM7Fk8z+1VA8wfAnjVphRT1Am3J/XW3nr5+i28MB2t
        UWeLvUy3wL4cWOesOdVJKNyyILP9l/tTTrVdhIG2jg==
X-Google-Smtp-Source: APBJJlFmy1ZRRYLp9p3+kpaID4akaDsSWDLGkuxREQ5NapLrUhU11R775skqJCYGTPsOjHSIxTsU4qsi8EGeGF0DDL0=
X-Received: by 2002:ac8:5987:0:b0:403:dcd4:b9b1 with SMTP id
 e7-20020ac85987000000b00403dcd4b9b1mr348591qte.18.1690321608276; Tue, 25 Jul
 2023 14:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <e5a6c3be-6dd3-4c85-9c5b-f9fb7aca0b36@rowland.harvard.edu>
 <0000000000007fc04d06011e274f@google.com> <c9bb72e0-8e02-4568-bd43-6897f9c94d12@rowland.harvard.edu>
 <CACGdZYL_dPFp-yHWHGC3vxyv4R4dYtSJe5GPcN0NjG2qaz+xmg@mail.gmail.com> <248d9759-aef7-45ce-b0a4-6c1cafee76c9@rowland.harvard.edu>
In-Reply-To: <248d9759-aef7-45ce-b0a4-6c1cafee76c9@rowland.harvard.edu>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Tue, 25 Jul 2023 14:46:37 -0700
Message-ID: <CACGdZY+qJ7P8FZj6ZGmcDkf2YH7LRBnfvuwiro4ZF37+owHo9g@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 read_descriptors (3)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000b2fe8060156abde"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000b2fe8060156abde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 2:30=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Tue, Jul 25, 2023 at 01:42:01PM -0700, Khazhy Kumykov wrote:
> > On Tue, Jul 25, 2023 at 12:26=E2=80=AFPM Alan Stern <stern@rowland.harv=
ard.edu> wrote:
>
> > > @@ -2671,12 +2671,17 @@ int usb_authorize_device(struct usb_devi
> > >         }
> > >
> > >         if (usb_dev->wusb) {
> > > -               result =3D usb_get_device_descriptor(usb_dev, sizeof(=
usb_dev->descriptor));
> > > -               if (result < 0) {
> > > +               struct usb_device_descriptor *descr;
> > > +
> > > +               descr =3D usb_get_device_descriptor(usb_dev);
> > > +               if (IS_ERR(descr)) {
> > > +                       result =3D PTR_ERR(descr);
> > >                         dev_err(&usb_dev->dev, "can't re-read device =
descriptor for "
> > >                                 "authorization: %d\n", result);
> > >                         goto error_device_descriptor;
> > >                 }
> > > +               usb_dev->descriptor =3D *descr;
> > Hmm, in your first patch you rejected diffs to the descriptor here,
> > which might be necessary - since we don't re-initialize the device so
> > can get a similar issue if the bad usb device decides to change
> > bNumConfigurations to cause a buffer overrun. (This also stuck out to
> > me as an exception to the "descriptors should be immutable" comment
> > later in the patch.
>
> I removed that part of the previous patch because there's no point to
> it.  None of this code ever gets executed; the usb_dev->wusb test can
> never succeed because the kernel doesn't support wireless USB any more.
> (I asked Greg KH about that in a separate email thread:
> <https://lore.kernel.org/linux-usb/2a21cefa-99a7-497c-901f-3ea097361a80@r=
owland.harvard.edu/#r>.)
>
> A later patch will remove all of the wireless USB stuff.  The only real
> reason for leaving this much of the code there now is to prevent
> compilation errors and keep the form looking right.
Ah ok, cool.

>
> > > @@ -6018,7 +6064,7 @@ static int usb_reset_and_verify_device(s
> > >                 /* ep0 maxpacket size may change; let the HCD know ab=
out it.
> > >                  * Other endpoints will be handled by re-enumeration.=
 */
> > >                 usb_ep0_reinit(udev);
> > > -               ret =3D hub_port_init(parent_hub, udev, port1, i);
> > > +               ret =3D hub_port_init(parent_hub, udev, port1, i, &de=
scriptor);
> > Looks like this is the only caller that passes &descriptor, and it
> > just checks that it didn't change. Would it make sense to put the
> > enitre descriptors_changed stanza in hub_port_init, for the re-init
> > case?
>
> The descriptors_changed check has to be _somewhere_, either here or
> there.  I don't see what difference it makes whether the check is done
> in this routine or in hub_port_init.  Since it doesn't matter, why
> change the existing code?
No strong feelings, but it lets us remove the variable in
usb_reset_and_verify_device() and directly check on the malloc'd copy,
instead of copying back up to here.

Overall, looks good to my naive eyes.

CVE-2023-37453 was filed for this syzbot report, I'm not sure how that
system gets tracked, but might be good to mention for folks looking
for a fix.

Thanks,
Khazhy

--0000000000000b2fe8060156abde
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
2d1HymA53tUP1hUwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBADeZduKRV5+J7StRkfoY
hBDfCkyRbFphFmeJ+0A1fPxECLLkrXR2izyctzMAGZH2ceScAlECO1r3aEQcyx9n7/YlMc24ZF0I
++9b72/wv6J6POICeIj6MgschmHIUz4Rw4H5IdBLo62N0jBBzv2T9ASRAl7Yryl6tHUN5X5228Tt
3LJe5Gtb1cm22DdXBM3xnD7Kd59ls9j/tz5I+yEsLIK7zQk7hBt87a31T55CTVgMQZ4lTavG5vdz
vEb7YC0jFAT8SmYmtSOr+4aZJRIwVjXlI04Mfr3jcbqDnzfv0VgVp5UlzQK4aApofbSsSDeXsDR+
t30gEkeMNUvUqd6PaxYxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAGy8e6bI55p/yISlXXGSrAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO4sUzGu
dX1QFnkeHRaZiOcF11wRmv5YGlIhqywBIcHpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMDcyNTIxNDY0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB72r8M7oHnFPwuoWSjTwV+4VMj
XOq4WYWPVp+lZs0FwaN7unk0978nl5LUemkOkdJ/GdAzE1RK8MQoSPbKLeR74X+ObDRq+uML4FHk
4AnbaFZPqIp62ngEWy0S5TjvrN5HJIlpMUSrHn+/2akmxxkATi2+t2Dn6TfhnJ1GpjQW53AUlBJp
yKZFZ9UyhdfwkrCWxX1dtvjRTnaegp/xHAO0HU0OUC8F088wccxx1azWXECbz03XBkIHYqpjFp1z
bH29dNAJAFWT9LuMFIGcDqLpQsV/Uy2W0xssOqVOb7X3GWSjM1jE8fJM0eq5tItdbpD8AJfoO6AE
UKVF7Qk7ED3h
--0000000000000b2fe8060156abde--
