Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690CF7E9B50
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjKMLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjKMLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:41:35 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9CAD4A;
        Mon, 13 Nov 2023 03:41:30 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231113114127euoutp0272c67c42f2763c59364f0fdaf6ede18f~XK_51PlBj1968919689euoutp02C;
        Mon, 13 Nov 2023 11:41:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231113114127euoutp0272c67c42f2763c59364f0fdaf6ede18f~XK_51PlBj1968919689euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699875687;
        bh=00BaRMy10DoZwXsc828mOv4dAkFMOvcakVZtw0kuAd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxGdh/PUhfCFG0n0FMQE9gvu2j8XF/XBM0v83ep9FpWSS6Xt6OzrgOTnDCTqrck5G
         acvUCOJ1mEUmc6EVduRutPhQC4xKF6Gv56RzLC8bR/eoGAmkYdXMH4ybkx31BxOeO4
         isP9mzm3cOj1TXfj3JI6h/Q1Eiy80oyMmywpLtT0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231113114127eucas1p1d4c81931f68d49d32741ce16a79cf4d0~XK_5uwnat0420804208eucas1p17;
        Mon, 13 Nov 2023 11:41:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 10.BD.09552.76B02556; Mon, 13
        Nov 2023 11:41:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231113114127eucas1p2b407933cf1f685c218b259d643b21313~XK_5W8MjS0799307993eucas1p2p;
        Mon, 13 Nov 2023 11:41:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231113114127eusmtrp2deba170cd0d4869ba070d70ef3561e21~XK_5WZrus1925619256eusmtrp2L;
        Mon, 13 Nov 2023 11:41:27 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-3a-65520b6708df
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.4E.09274.66B02556; Mon, 13
        Nov 2023 11:41:26 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231113114126eusmtip240fe67ed2677c5c5d0ad11635d472841~XK_5JDMT10056300563eusmtip20;
        Mon, 13 Nov 2023 11:41:26 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2] hwmon: (hp-wmi-sensors) Fix failure to load on
 EliteDesk 800 G6
Date:   Mon, 13 Nov 2023 12:41:25 +0100
In-Reply-To: <20231105192054.24833-1-james@equiv.tech> (James Seo's message
        of "Sun, 5 Nov 2023 11:20:54 -0800")
Message-ID: <oypijdpm0dkhi2.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rp3EGpBmvviljMu3aQ2eLshECL
        9tdbGS0u75rDZvFk4Rkmi4nPD7A6sHl8777I5PHhY5zHzu8N7B7rt1xl8fi8SS6ANYrLJiU1
        J7MstUjfLoEr49ezvIIlfhWvD+9gaWCcaN/FyMkhIWAi0Xn1PGsXIxeHkMAKRonm5VfYIJwv
        jBL3L/1kAqkSEvjMKHFwdQpMx9FzhxkhipYzSpz9ux+q6AWjxPkNJV2MHBxsAnoSa9dGgIRF
        BBQkWudsAKtnFljGKPHt1kd2kISwQLhEZ/cdRhCbRUBVYundbjYQm1OgSKK3qxUszitgLtHZ
        MgHMFhWwlDi+tZ0NIi4ocXLmExYQm1kgV2Lm+TdgCyQEXnBITJ65lx3iUheJrvNvWCBsYYlX
        x7dAxWUk/u+czwTR0M4o0XRlISuEM4FR4nNHExNElbXEnXO/2CBsR4kN1y4xg7wmIcAnceOt
        IMRmPolJ26ZDhXklOtqEIKpVJNb174HaKyXR+2oFI0SJh8TrheqQgOtklOjtW800gVFhFpJ/
        ZiH5ZxZQC7OApsT6XfoQYW2JZQtfM0PYthLr1r1nWcDIuopRPLW0ODc9tdg4L7Vcrzgxt7g0
        L10vOT93EyMwGZ3+d/zrDsYVrz7qHWJk4mA8xKgC1Pxow+oLjFIsefl5qUoivHmaAalCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTNu5fMz6uPu9qpkX
        iK2N2fddscFN+nffhtreH5v3Lvq6WnJra63N+30uDkUTBTxCmVjNVZ+evminVOJyNLOE7ZKx
        R4b1pTTRCUc/2X9wefxaU/HN43jv/bzeRh7f+nJ/KBVU/23+O8tlRfCMxUf97sz4Mn/HFGv+
        2ayCZ6Zur1ldV/v27s7oaIVb6xry/YoFMw/c+Dh9P3vsloBvG97ZTE6qL3iTuU7ReeJL8a3J
        giH7TtU/uFy0393R1FXghrfD3/u3Ilzle78szrMJFuadLjpT+8eSs9unrP3wVljS22mF5uf7
        4V1pAVfiw2fJ3r+zLfdk5/wDSvO+lBw/WeMVMce4KG+xe1Pr6izjb6omB5VYijMSDbWYi4oT
        ASpBS+7BAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7pp3EGpBvd3mlvMu3aQ2eLshECL
        9tdbGS0u75rDZvFk4Rkmi4nPD7A6sHl8777I5PHhY5zHzu8N7B7rt1xl8fi8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49ezvIIlfhWv
        D+9gaWCcaN/FyMkhIWAicfTcYcYuRi4OIYGljBLdD3YCORxACSmJlXPTIWqEJf5c62KDqHnG
        KLGyqYUZpIZNQE9i7doIkBoRAQWJ1jkbwOYwC6xglNi9bzUjSEJYIFyis/sOmC0kYCrRvGMP
        M4jNIqAqsfRuNxuIzSlQJPG+s58FxOYVMJfobJkAVi8qYClxfGs7G0RcUOLkzCdgNcwC2RJf
        Vz9nnsAoMAtJahaS1Cyg85gFNCXW79KHCGtLLFv4mhnCtpVYt+49ywJG1lWMIqmlxbnpucVG
        esWJucWleel6yfm5mxiBkbTt2M8tOxhXvvqod4iRiYPxEKMKUOejDasvMEqx5OXnpSqJ8OZp
        BqQK8aYkVlalFuXHF5XmpBYfYjQFem0is5Rocj4wxvNK4g3NDEwNTcwsDUwtzYyVxHk9CzoS
        hQTSE0tSs1NTC1KLYPqYODilGphK/gko2Fjo5aY7WF+fcGzGrpIN9seY2LMS5/zNmn2aR4wv
        fgmj4Qcxng9/F2x6Jay2Zc6kiVfPLyzZkScgmqlVduVBiOQPAVGLN7uXr99y7nkZX3vVWUNt
        Wa/sfOuvm51Wl5rdT3+9+E/aqYvqEx2yNhi9muqmEFDuJrU6Z+nJUPlXxk2nZvFkzH+x+/f5
        ZYL/Ct1bLf3e7rFoZ11478Sr0x1/o6ak8q/crmChnTQxcONOhnrzHW7/DX2Z8ivaFtdZabO7
        cefXl61/mbyRxVXp5tElt5rYzRIeXqzPX3ml4XgpY72BrFbNx/+mNaqiM8Pu3vD3+ukqe/PZ
        hV8N3Zt2VBXPe73lyfsNK2Z1Pi9TYinOSDTUYi4qTgQAKtNU5DkDAAA=
X-CMS-MailID: 20231113114127eucas1p2b407933cf1f685c218b259d643b21313
X-Msg-Generator: CA
X-RootMTR: 20231113114127eucas1p2b407933cf1f685c218b259d643b21313
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231113114127eucas1p2b407933cf1f685c218b259d643b21313
References: <20231105192054.24833-1-james@equiv.tech>
        <CGME20231113114127eucas1p2b407933cf1f685c218b259d643b21313@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2023-11-05 nie 11:20>, when James Seo wrote:
> The EliteDesk 800 G6 stores a raw WMI string within the ACPI object in its
> BIOS corresponding to one instance of HPBIOS_PlatformEvents.Name. This is
> evidently a valid way of representing a WMI data item as far as the Micro=
soft
> ACPI-WMI mapper is concerned, but is preventing the driver from loading.
>
> This seems quite rare, but add support for such strings. Treating this as=
 a
> quirk pretty much means adding that support anyway.
>
> Also clean up an oversight in update_numeric_sensor_from_wobj() in which =
the
> result of hp_wmi_strdup() was being used without error checking.
>
> Reported-by: Lukasz Stelmach <l.stelmach@samsung.com>
> Closes: https://lore.kernel.org/linux-hwmon/7850a0bd-60e7-88f8-1d6c-0bb0e=
3234fdc@roeck-us.net/
> Signed-off-by: James Seo <james@equiv.tech>
> ---
>
> Changes v1->v2:
> * Remove DMI-based workaround logic
> * Add full support for raw WMI strings
>   - Improve UTF-16 validation and conversion for the general case
>   - Support such strings if they occur in HPBIOS_BIOSEvent objects
> * Only use the result of hp_wmi_strdup() in update_numeric_sensor_from_wo=
bj()
>   if the call succeeded
>
> History:
> v1: https://lore.kernel.org/linux-hwmon/20231103181931.677796-1-james@equ=
iv.tech/
>
> ---
>
>  drivers/hwmon/hp-wmi-sensors.c | 127 ++++++++++++++++++++++++++++-----
>  1 file changed, 111 insertions(+), 16 deletions(-)
>

Tested-by: Lukasz Stelmach <l.stelmach@samsung.com>

> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensor=
s.c
> index 17ae62f88bbf..bdd7ca163593 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -17,6 +17,8 @@
>   *     Available: https://github.com/linuxhw/ACPI
>   * [4] P. Roh=C3=A1r, "bmfdec - Decompile binary MOF file (BMF) from WMI=
 buffer",
>   *     2017. [Online]. Available: https://github.com/pali/bmfdec
> + * [5] Microsoft Corporation, "Driver-Defined WMI Data Items", 2017. [On=
line].
> + *     Available: https://learn.microsoft.com/en-us/windows-hardware/dri=
vers/kernel/driver-defined-wmi-data-items
>   */
>=20=20
>  #include <linux/acpi.h>
> @@ -24,6 +26,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/jiffies.h>
>  #include <linux/mutex.h>
> +#include <linux/nls.h>
>  #include <linux/units.h>
>  #include <linux/wmi.h>
>=20=20
> @@ -395,6 +398,50 @@ struct hp_wmi_sensors {
>  	struct mutex lock;	/* Lock polling WMI and driver state changes. */
>  };
>=20=20
> +static bool is_raw_wmi_string(const u8 *pointer, u32 length)
> +{
> +	const u16 *ptr;
> +	u16 len;
> +
> +	/* WMI strings are length-prefixed UTF-16 [5]. */
> +	if (length <=3D sizeof(*ptr))
> +		return false;
> +
> +	length -=3D sizeof(*ptr);
> +	ptr =3D (const u16 *)pointer;
> +	len =3D *ptr;
> +
> +	return len <=3D length && !(len & 1);
> +}
> +
> +static char *convert_raw_wmi_string(const u8 *buf)
> +{
> +	const wchar_t *src;
> +	unsigned cps;
> +	unsigned len;
> +	char *dst;
> +	int i;
> +
> +	src =3D (const wchar_t *)buf;
> +
> +	/* Count UTF-16 code points. Exclude trailing null padding. */
> +	cps =3D *src / sizeof(*src);
> +	while (cps && !src[cps])
> +		cps--;
> +
> +	/* Each code point becomes up to 3 UTF-8 characters. */
> +	len =3D min(cps * 3, HP_WMI_MAX_STR_SIZE - 1);
> +
> +	dst =3D kmalloc((len + 1) * sizeof(*dst), GFP_KERNEL);
> +	if (!dst)
> +		return NULL;
> +
> +	i =3D utf16s_to_utf8s(++src, cps, UTF16_LITTLE_ENDIAN, dst, len);
> +	dst[i] =3D '\0';
> +
> +	return dst;
> +}
> +
>  /* hp_wmi_strdup - devm_kstrdup, but length-limited */
>  static char *hp_wmi_strdup(struct device *dev, const char *src)
>  {
> @@ -412,6 +459,23 @@ static char *hp_wmi_strdup(struct device *dev, const=
 char *src)
>  	return dst;
>  }
>=20=20
> +/* hp_wmi_wstrdup - hp_wmi_strdup, but for a raw WMI string */
> +static char *hp_wmi_wstrdup(struct device *dev, const u8 *buf)
> +{
> +	char *src;
> +	char *dst;
> +
> +	src =3D convert_raw_wmi_string(buf);
> +	if (!src)
> +		return NULL;
> +
> +	dst =3D hp_wmi_strdup(dev, strim(src));	/* Note: Copy is trimmed. */
> +
> +	kfree(src);
> +
> +	return dst;
> +}
> +
>  /*
>   * hp_wmi_get_wobj - poll WMI for a WMI object instance
>   * @guid: WMI object GUID
> @@ -462,8 +526,14 @@ static int check_wobj(const union acpi_object *wobj,
>  	for (prop =3D 0; prop <=3D last_prop; prop++) {
>  		type =3D elements[prop].type;
>  		valid_type =3D property_map[prop];
> -		if (type !=3D valid_type)
> +		if (type !=3D valid_type) {
> +			if (type =3D=3D ACPI_TYPE_BUFFER &&
> +			    valid_type =3D=3D ACPI_TYPE_STRING &&
> +			    is_raw_wmi_string(elements[prop].buffer.pointer,
> +					      elements[prop].buffer.length))
> +				continue;
>  			return -EINVAL;
> +		}
>  	}
>=20=20
>  	return 0;
> @@ -480,7 +550,9 @@ static int extract_acpi_value(struct device *dev,
>  		break;
>=20=20
>  	case ACPI_TYPE_STRING:
> -		*out_string =3D hp_wmi_strdup(dev, strim(element->string.pointer));
> +		*out_string =3D element->type =3D=3D ACPI_TYPE_BUFFER ?
> +			hp_wmi_wstrdup(dev, element->buffer.pointer) :
> +			hp_wmi_strdup(dev, strim(element->string.pointer));
>  		if (!*out_string)
>  			return -ENOMEM;
>  		break;
> @@ -861,7 +933,9 @@ update_numeric_sensor_from_wobj(struct device *dev,
>  {
>  	const union acpi_object *elements;
>  	const union acpi_object *element;
> -	const char *string;
> +	const char *new_string;
> +	char *trimmed;
> +	char *string;
>  	bool is_new;
>  	int offset;
>  	u8 size;
> @@ -885,11 +959,21 @@ update_numeric_sensor_from_wobj(struct device *dev,
>  	offset =3D is_new ? size - 1 : -2;
>=20=20
>  	element =3D &elements[HP_WMI_PROPERTY_CURRENT_STATE + offset];
> -	string =3D strim(element->string.pointer);
> -
> -	if (strcmp(string, nsensor->current_state)) {
> -		devm_kfree(dev, nsensor->current_state);
> -		nsensor->current_state =3D hp_wmi_strdup(dev, string);
> +	string =3D element->type =3D=3D ACPI_TYPE_BUFFER ?
> +		convert_raw_wmi_string(element->buffer.pointer) :
> +		element->string.pointer;
> +
> +	if (string) {
> +		trimmed =3D strim(string);
> +		if (strcmp(trimmed, nsensor->current_state)) {
> +			new_string =3D hp_wmi_strdup(dev, trimmed);
> +			if (new_string) {
> +				devm_kfree(dev, nsensor->current_state);
> +				nsensor->current_state =3D new_string;
> +			}
> +		}
> +		if (element->type =3D=3D ACPI_TYPE_BUFFER)
> +			kfree(string);
>  	}
>=20=20
>  	/* Old variant: -2 (not -1) because it lacks the Size property. */
> @@ -996,11 +1080,15 @@ static int check_event_wobj(const union acpi_objec=
t *wobj)
>  			  HP_WMI_EVENT_PROPERTY_STATUS);
>  }
>=20=20
> -static int populate_event_from_wobj(struct hp_wmi_event *event,
> +static int populate_event_from_wobj(struct device *dev,
> +				    struct hp_wmi_event *event,
>  				    union acpi_object *wobj)
>  {
>  	int prop =3D HP_WMI_EVENT_PROPERTY_NAME;
>  	union acpi_object *element;
> +	acpi_object_type type;
> +	char *string;
> +	u32 value;
>  	int err;
>=20=20
>  	err =3D check_event_wobj(wobj);
> @@ -1009,20 +1097,24 @@ static int populate_event_from_wobj(struct hp_wmi=
_event *event,
>=20=20
>  	element =3D wobj->package.elements;
>=20=20
> -	/* Extracted strings are NOT device-managed copies. */
> -
>  	for (; prop <=3D HP_WMI_EVENT_PROPERTY_CATEGORY; prop++, element++) {
> +		type =3D hp_wmi_event_property_map[prop];
> +
> +		err =3D extract_acpi_value(dev, element, type, &value, &string);
> +		if (err)
> +			return err;
> +
>  		switch (prop) {
>  		case HP_WMI_EVENT_PROPERTY_NAME:
> -			event->name =3D strim(element->string.pointer);
> +			event->name =3D string;
>  			break;
>=20=20
>  		case HP_WMI_EVENT_PROPERTY_DESCRIPTION:
> -			event->description =3D strim(element->string.pointer);
> +			event->description =3D string;
>  			break;
>=20=20
>  		case HP_WMI_EVENT_PROPERTY_CATEGORY:
> -			event->category =3D element->integer.value;
> +			event->category =3D value;
>  			break;
>=20=20
>  		default:
> @@ -1511,8 +1603,8 @@ static void hp_wmi_notify(u32 value, void *context)
>  	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
>  	struct hp_wmi_sensors *state =3D context;
>  	struct device *dev =3D &state->wdev->dev;
> +	struct hp_wmi_event event =3D {};
>  	struct hp_wmi_info *fan_info;
> -	struct hp_wmi_event event;
>  	union acpi_object *wobj;
>  	acpi_status err;
>  	int event_type;
> @@ -1546,7 +1638,7 @@ static void hp_wmi_notify(u32 value, void *context)
>=20=20
>  	wobj =3D out.pointer;
>=20=20
> -	err =3D populate_event_from_wobj(&event, wobj);
> +	err =3D populate_event_from_wobj(dev, &event, wobj);
>  	if (err) {
>  		dev_warn(dev, "Bad event data (ACPI type %d)\n", wobj->type);
>  		goto out_free_wobj;
> @@ -1577,6 +1669,9 @@ static void hp_wmi_notify(u32 value, void *context)
>  out_free_wobj:
>  	kfree(wobj);
>=20=20
> +	devm_kfree(dev, event.name);
> +	devm_kfree(dev, event.description);
> +
>  out_unlock:
>  	mutex_unlock(&state->lock);
>  }
>
> base-commit: 0f564130e5c76f1e5cf0008924f6a6cd138929d9

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmVSC2YACgkQsK4enJil
gBCIiggApIBO18ogBUIg66CEO0URC76nRlCvr4U65Qv1IxRdmuEFACqySQxEH37l
Gv/7FTH1OcElUJkcOcCLMXvbl+IEN99UFGKru30p7cahqzTyXcIkDNCd/b7RAmRa
fMCmNRVGFfFVXBEqXw8gf2yXHixa5O9i/6oOZP/AOhoO3V7BQIlJqc/oKK6vH8s1
SuLS6TuW1THb5nGPAZ/jKTJHRyEZU+4ybvReDJPfROkBSZW2P2USOWrzzcLharkF
x2sR3/YFZoVaUMAuzAR5M4QKdF89OSaERky+YmIwYOJ3GcGs1w6ie/32zlvjMfQi
ysCX6Ij/peNq9e55dJpR3luZ6b3dRQ==
=AOIR
-----END PGP SIGNATURE-----
--=-=-=--
