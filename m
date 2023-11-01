Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4F17DE8BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345806AbjKAXDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjKAXDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:03:24 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF242B9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:03:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7781bc3783fso17993285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698879800; x=1699484600; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lOXnFGPRns1GqSfr0pzuV2Sf+DD9D9FbK/vUgQARMyw=;
        b=L7jNgyHduS1AGJ92LM3K0rCsB2m6iTGgiyXh4ddeaw/99IYkJdGZMLYWk4OFbAeDv2
         3b8bl+NvnAWmu3RawsVRLlL+ZSXxJdm4c9+czPWJtoJnVbvVpFm1OaCqkfwpvHRis1KY
         l0zT0S+7VyeaApLsoUNAAb+GInYRRxIPBy4jKG/ztGFtpoVnnEcEc/uNMS/sekVh6SG6
         3e858DbYPR8LFqyvlyk6jDYyosYwdCKXL3zDi78/flCidk3fDvonhiJXgAbc/oI9D157
         tKLDficKSFrWKMRXdxhjHgCvQTmKnumEAkcnHKD2e1IaHBP0VaumWhCwX9UDwYyZNH62
         3xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698879800; x=1699484600;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOXnFGPRns1GqSfr0pzuV2Sf+DD9D9FbK/vUgQARMyw=;
        b=ckRX93FgDKVaJMHu8cQT5tzzdyo1DBpKBJ4CuSTnsXKs9BqEq3I1Vyi2OAQ15ZyH2K
         WWKKwfybmiZ0vQdSvoSE17pUAi7Jw51RuQjjfbxbnM3omHqxnkF6t71Cn7FlU1ZUn/mU
         0FzrxPq9lQArG2W9XJeotSOsJ76gMA0BKpoJ9IEudhlEM57p1oPfRo02Q3iFigl1QMqO
         9njIYpNNgTQLBLuxfWJ3CgS52IrqeB5TrvyyvAoy3BTjlbe/tXYKla+it1HR4ki4+tfC
         DFwh9+HRZkU0bKcPPgJlBYiQ6SGvT8AwrXllC4bBygaMiq3PTWoz27S77w8Htp6g2Siw
         4dIw==
X-Gm-Message-State: AOJu0YxPB3RoHfFOdohZYtenn0K8YV/YMB8rQO8BnWw934k7roytVyEQ
        VWpVHFxNUvlU8Gjzfo2UcMU=
X-Google-Smtp-Source: AGHT+IHQcSCPws1aHPOQv+iAHpNOMbnXE+jELTeL6T27BiySlgg++bXKgrnxQlbdLBt1sUnF7tO+YA==
X-Received: by 2002:ad4:5765:0:b0:66d:9d15:6876 with SMTP id r5-20020ad45765000000b0066d9d156876mr19156152qvx.65.1698879799650;
        Wed, 01 Nov 2023 16:03:19 -0700 (PDT)
Received: from [192.168.2.14] ([74.15.198.235])
        by smtp.gmail.com with ESMTPSA id f28-20020ad4559c000000b0063f88855ef2sm1859874qvx.101.2023.11.01.16.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 16:03:19 -0700 (PDT)
Message-ID: <8d7a33b3-9bc6-45a0-b5c2-d4bf1621d5e5@gmail.com>
Date:   Wed, 1 Nov 2023 19:03:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.1
Subject: Re: [PATCH drm-misc-next v4] drm/sched: implement dynamic job-flow
 control
Content-Language: en-CA, en-US
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        boris.brezillon@collabora.com, christian.koenig@amd.com,
        faith@gfxstrand.net, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231031002655.38707-1-dakr@redhat.com>
 <6fa280dd-af9c-4171-86b7-cbef91fd9ff8@gmail.com> <ZUG2vzzzYc87nGEV@pollux>
From:   Luben Tuikov <ltuikov89@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <ZUG2vzzzYc87nGEV@pollux>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ff0a4To1xV8RoZz681C80nUP"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ff0a4To1xV8RoZz681C80nUP
Content-Type: multipart/mixed; boundary="------------ofSdRHkQW97FHvScJiVP0PKl";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Danilo Krummrich <dakr@redhat.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
 boris.brezillon@collabora.com, christian.koenig@amd.com,
 faith@gfxstrand.net, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Message-ID: <8d7a33b3-9bc6-45a0-b5c2-d4bf1621d5e5@gmail.com>
Subject: Re: [PATCH drm-misc-next v4] drm/sched: implement dynamic job-flow
 control
References: <20231031002655.38707-1-dakr@redhat.com>
 <6fa280dd-af9c-4171-86b7-cbef91fd9ff8@gmail.com> <ZUG2vzzzYc87nGEV@pollux>
In-Reply-To: <ZUG2vzzzYc87nGEV@pollux>

--------------ofSdRHkQW97FHvScJiVP0PKl
Content-Type: multipart/mixed; boundary="------------HdLiRkQOv2L4EHpT7n09PLrL"

--------------HdLiRkQOv2L4EHpT7n09PLrL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-10-31 22:23, Danilo Krummrich wrote:
> Hi Luben,
>=20

[snip]
>>> @@ -187,12 +251,14 @@ void drm_sched_rq_remove_entity(struct drm_sche=
d_rq *rq,
>>>  /**
>>>   * drm_sched_rq_select_entity_rr - Select an entity which could prov=
ide a job to run
>>>   *
>>> + * @sched: the gpu scheduler
>>>   * @rq: scheduler run queue to check.
>>>   *
>>>   * Try to find a ready entity, returns NULL if none found.
>>>   */
>>>  static struct drm_sched_entity *
>>> -drm_sched_rq_select_entity_rr(struct drm_sched_rq *rq)
>>> +drm_sched_rq_select_entity_rr(struct drm_gpu_scheduler *sched,
>>> +			      struct drm_sched_rq *rq)
>>>  {
>>>  	struct drm_sched_entity *entity;
>>> =20
>>> @@ -202,6 +268,14 @@ drm_sched_rq_select_entity_rr(struct drm_sched_r=
q *rq)
>>>  	if (entity) {
>>>  		list_for_each_entry_continue(entity, &rq->entities, list) {
>>>  			if (drm_sched_entity_is_ready(entity)) {
>>> +				/* If we can't queue yet, preserve the current
>>> +				 * entity in terms of fairness.
>>> +				 */
>>> +				if (!drm_sched_can_queue(sched, entity)) {
>>> +					spin_unlock(&rq->lock);
>>> +					return ERR_PTR(-ENOSPC);
>>> +				}
>>> +
>>>  				rq->current_entity =3D entity;
>>>  				reinit_completion(&entity->entity_idle);
>>>  				spin_unlock(&rq->lock);
>>> @@ -211,8 +285,15 @@ drm_sched_rq_select_entity_rr(struct drm_sched_r=
q *rq)
>>>  	}
>>> =20
>>>  	list_for_each_entry(entity, &rq->entities, list) {
>>> -
>>>  		if (drm_sched_entity_is_ready(entity)) {
>>> +			/* If we can't queue yet, preserve the current entity in
>>> +			 * terms of fairness.
>>> +			 */
>>> +			if (!drm_sched_can_queue(sched, entity)) {
>>> +				spin_unlock(&rq->lock);
>>> +				return ERR_PTR(-ENOSPC);
>>> +			}
>>> +
>>>  			rq->current_entity =3D entity;
>>>  			reinit_completion(&entity->entity_idle);
>>>  			spin_unlock(&rq->lock);
>>> @@ -231,12 +312,14 @@ drm_sched_rq_select_entity_rr(struct drm_sched_=
rq *rq)
>>>  /**
>>>   * drm_sched_rq_select_entity_fifo - Select an entity which provides=
 a job to run
>>>   *
>>> + * @sched: the gpu scheduler
>>>   * @rq: scheduler run queue to check.
>>>   *
>>>   * Find oldest waiting ready entity, returns NULL if none found.
>>>   */
>>>  static struct drm_sched_entity *
>>> -drm_sched_rq_select_entity_fifo(struct drm_sched_rq *rq)
>>> +drm_sched_rq_select_entity_fifo(struct drm_gpu_scheduler *sched,
>>> +				struct drm_sched_rq *rq)
>>>  {
>>>  	struct rb_node *rb;
>>> =20
>>> @@ -246,6 +329,14 @@ drm_sched_rq_select_entity_fifo(struct drm_sched=
_rq *rq)
>>> =20
>>>  		entity =3D rb_entry(rb, struct drm_sched_entity, rb_tree_node);
>>>  		if (drm_sched_entity_is_ready(entity)) {
>>> +			/* If we can't queue yet, preserve the current entity in
>>> +			 * terms of fairness.
>>> +			 */
>>> +			if (!drm_sched_can_queue(sched, entity)) {
>>> +				spin_unlock(&rq->lock);
>>> +				return ERR_PTR(-ENOSPC);
>>> +			}
>>> +
>>
>> So, this kinda did this abrupt "return" in v2, then it was fixed fine =
in v3,
>> and now I see we return and return an error now, which doesn't seem to=
 be used
>> by anyone. In fact, in drm_sched_select_entity(), we do this,
>>
>> -	return entity;
>> +	return IS_ERR(entity) ? NULL : entity;
>>
>> So, it's perhaps best to leave this as it was in v3, and if in the fut=
ure
>> we need to distinguish between the type of error, then that future pat=
ch
>> would do that and also show how this is used with new code and logic.
>>
>> There is little value to over-engineer this right now, given that in
>> the future, the logic may be more esoteric than we can think of.
>=20
> Ok, maybe what I do here is a little bit subtle and requires a comment.=
 Let me
> explain.
>=20
> The reason I return an ERR_PTR() instead of NULL is to indicate to
> drm_sched_select_entity() to break out of the runqueue loop
> (drm_sched_select_entity() breaks the loop when the returned entity is =
not
> NULL).
>=20
> Without that, we'd continue the runqueue loop in drm_sched_select_entit=
y() and
> retry with the next lower priority. This could lead to prioritiy invers=
ion of
> the runqueues, since a lower priority runqueue with jobs with less cred=
its could
> stall a higher priority runqueue with jobs with more credits.
>=20
> Hence, in drm_sched_select_entity() we need to be able to distinguish b=
etween
> drm_sched_rq_select_entity_fifo()/drm_sched_rq_select_entity_rr() can't=
 find an
> entity and they *can* find an entity, but it's job doesn't fit on the r=
ing.
>=20
> I think what makes it subtle in this patch is that in drm_sched_select_=
entity()
> the condition already fits with
>=20
> 	if (entity)
> 		break;
>=20
> because we want to break this loop when we actually found an entity, or=
 when
> there is no space on the ring buffer, but we want to keep checking the =
other
> runqueues if entity is NULL.

Okay, that's fine, but please update the head comment of
drm_sched_rq_select_entity_{rr,fifo}() and of=20
drm_sched_select_entity() to explain what is being returned.

This invariably adds to the documentation which some want added to DRM--l=
et's
first all start documenting code which we add ourselves.

I'd imagine this would look something like this, for each _{rr,fifo},
respectively, (remove content with braces {}, x4),

/**
 * drm_sched_rq_select_entity_{LT: rr,fifo} - Select an entity which prov=
ides a job to run
 * @sched: the gpu scheduler
 * @rq: scheduler run queue to check.
 *
 * Try to find a ready entity, returns NULL if none found. {LT: RR}
 * Find oldest waiting ready entity, returns NULL if none found. {LT: FIF=
O}
 *
 * Return an entity if one is found; return an error-pointer (!NULL) if a=
n entity
 * was ready, but the scheduler had insufficient credits to accommodate i=
ts job;
 * return NULL, if no ready entity was found. {LT: for both RR and FIFO.}=

 */

And,

/**
 * drm_sched_select_entity - Select the next entity to process
 * @sched: the scheduler instance
 *
 * Return an entity to process or NULL if none are found.
 *
 * Note, that we break out of the for-loop when "entity"
 * is non-null, which can also be an error-pointer--this assures
 * we don't process lower priority run-queues. See comments
 * in the respectively called functions.
 */

[snip]
>>> +
>>> +	/**
>>> +	 * @update_job_credits: Called once the scheduler is considering th=
is
>>> +	 * job for execution.
>>
>> "once" --> "when", a close cousin of "once", but clearer in code comme=
nts.
>> It is called in fact as many times as the job is considered to be push=
ed down
>> to hardware, if we couldn't previously.
>=20
> Sure, gonna change that.
>=20
>>
>>> +	 *
>>> +	 * This callback returns the number of credits this job would take =
if
>>
>> Too many repetitions of "this". Instead of "this job", say "the job".
>=20
> Gonna fix.

Great.

Could you please rebase your patch on top of drm-misc-next--Matthew's Xe =
changes
went in this afternoon.

Thanks!
--=20
Regards,
Luben

--------------HdLiRkQOv2L4EHpT7n09PLrL
Content-Type: application/pgp-keys; name="OpenPGP_0x4C15479431A334AF.asc"
Content-Disposition: attachment; filename="OpenPGP_0x4C15479431A334AF.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1A
PnbnnRHNIkx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoA
QRYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiIC
BhUKCQgLAgQWAgMBAh4HAheAAAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlT
MqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfyJwktF7REl1yt7IU2Sye1qmQMfJxdt9JM
bMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSPcCE8uGe7FWo8C+nTSyWPXKTx
9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJl
OiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKoaMDzO9eG
z69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA=3D=3D
=3DqCaZ
-----END PGP PUBLIC KEY BLOCK-----

--------------HdLiRkQOv2L4EHpT7n09PLrL--

--------------ofSdRHkQW97FHvScJiVP0PKl--

--------------ff0a4To1xV8RoZz681C80nUP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZULZLgUDAAAAAAAKCRBMFUeUMaM0r1r2
AQDz47a1RfxaLTIenT/Ge+tFvE5IKotab5N+A2vTsRaDEQEAjJ2Q3SE4b6LuiQyZgSu4rWtDVa5v
S+t5dQJq8b5tBwU=
=hKrT
-----END PGP SIGNATURE-----

--------------ff0a4To1xV8RoZz681C80nUP--
