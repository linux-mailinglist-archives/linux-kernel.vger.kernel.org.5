Return-Path: <linux-kernel+bounces-105300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 442B987DBA6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0451AB210AE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 23:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0351C68D;
	Sat, 16 Mar 2024 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="cQE57kVy"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2210A05;
	Sat, 16 Mar 2024 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710629996; cv=none; b=taY2q41OhWieFp4VscxWAWcxNY8+XfOi7lCoF/5FGVA6+aPN3ks7MgX9qoC7F0GFnaQb1INgWLQ1wkJXqGreOSz3w2gfka4Kz9gGcjj5t8J789znCa7bavXNXf0+eALjTrnrewytS9c10494HX012TvL8JJYqkmkrW3159ASq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710629996; c=relaxed/simple;
	bh=NRgDhvaYPEeLcIKAQpXMNfm1dGckeCFgcdxENIMatIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NadmW+Eu02asjwupG6Ky6R8eF9I7luXCS8f8m3R+rZlNx20KJj2BDaactioV74AaheE/8rAhrxAXKp3WCUhxvnm5kAohwHdLHNZnTyZZaWFNcdGNZvyjU8XywuCZug32NizkHHwfCjk833NvN9AQv6vz3+/ib2l0HYjVmgFKZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=cQE57kVy; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id C838B3085BF7;
	Sat, 16 Mar 2024 23:54:30 +0100 (CET)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:message-id:date:date:subject:subject:from:from:received
	:received:received; s=dkim20160331; t=1710629665; x=1712444066;
	 bh=7j/3TiXLozZC8C+fjLk9xTsD0yusn361QYPV7Zy/Cng=; b=cQE57kVy3Yrf
	muQsPOq9o9VxZlZWYVl2wY7FDsF5vK2ZgZ/RkAIGuF8p4Bmu1viyq8dSX/ZwnGO8
	rcuVnc3il16VZZS86mReojK7SNJ3y2sDwpd7p/mCZOmOlQafe6cJmDsVwrUXQQQo
	Pfqwi+bkli31ENinQgLDujpmodyTCSbgvZIaxLb/5bJlsknOcnbsirVI1pjSH9Nq
	HfEKaYr+3QfLTFDS6twvjG8MFCcXhxEPCOJFtEv/FEN8fKmDoUw48Mmln6oanPGx
	EdnlFzxmPrvHXot3vrqUnBh4vN2Sm8g3tc1htuBtqWlJgTeXcUeLyjhIjN5OrKir
	1GV6V9FuulBxVLaDkazIdt64xJgQ6YYD/2ASL4d8KJMKAV6hsAg0W2wbtsFZ7JfQ
	sSY5Sa/LBIE3q4a0iebK8k9zvvrhdU+8QxHAB4mmtPqDI1GI5/dQgTcKpjk2nHXM
	tG2YLfHNrgB4xbUuBlMYHfjOdCM3M+aVm6cVVYLYj/7OP/KP7hpl6mgR+kbx5kml
	0ElljQnQyT26XunU+L7YYcU3oKtuxHLwKpZ8aM4tHWg9cTCL15Er7E6Uukp3Y2b6
	7SW7DgBi5I08ys4sYdLSYssxthhx/0XoDIZOXzlpSyTur6K7l6WNtNbBFPuEBM4j
	/fL3Bo/3Ny05G6BfVlkRRL1X8nGcOUo=
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 8l27RRn-f50P; Sat, 16 Mar 2024 23:54:25 +0100 (CET)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id 061B73085BE5;
	Sat, 16 Mar 2024 23:54:24 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id 055CA30CA59B;
	Sat, 16 Mar 2024 23:54:23 +0100 (CET)
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] doc:it_IT: align Italian documentation
Date: Sat, 16 Mar 2024 23:54:00 +0100
Message-Id: <20240316225400.22590-1-federico.vaga@vaga.pv.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Translation for the following patches

commit 6e55b1cbf05d ("docs: try to encourage (netdev?) reviewers")
commit e49ad8530de9 ("CREDITS, MAINTAINERS, docs/process/howto: Update man-pages' maintainer")
commit 44ac5abac86b ("Documentation/security-bugs: move from admin-guide/ to process/")
commit 5a602de99797 ("Add .editorconfig file for basic formatting")
commit 129027b78c49 ("docs: deprecated.rst: Update an example")
commit efc0a7cfe9ec ("Docs/process/changes: Consolidate NFS-utils update links")
commit 383f30882197 ("Docs/process/changes: Replace http:// with https://")
commit 80fe9e51510b ("rust: upgrade to Rust 1.74.1")
commit c584476d477e ("doc: Add tar requirement to changes.rst")
commit b230235b3865 ("docs: Set minimal gtags / GNU GLOBAL version to 6.6.5")
commit 3e893e16af55 ("docs: Raise the minimum Sphinx requirement to 2.4.4")
commit 08ab786556ff ("rust: bindgen: upgrade to 0.65.1")
commit 185ea7676ef3 ("Documentation: coding-style: Update syntax highlighting for code-blocks")
commit 932be49b71e7 ("Documentation: coding-style: Fix indentation in code-blocks")
commit 5c7944ca7b13 ("coding-style: Add guidance to prefer dev_dbg")
commit c15ec3d1a287 ("Documentation: doc-guide: use '%' constant indicator in Return: examples")
commit 329ac9af902e ("docs: submitting-patches: Discuss interleaved replies")
commit 5382774515d4 ("(docs-next) A reworked process/index.rst")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/doc-guide/kernel-doc.rst            | 10 +--
 .../translations/it_IT/process/2.Process.rst  |  9 ++-
 .../translations/it_IT/process/4.Coding.rst   |  4 ++
 .../it_IT/process/7.AdvancedTopics.rst        | 19 ++++++
 .../translations/it_IT/process/changes.rst    | 36 ++++++----
 .../it_IT/process/coding-style.rst            | 12 +++-
 .../translations/it_IT/process/deprecated.rst |  2 +-
 .../translations/it_IT/process/howto.rst      |  6 +-
 .../translations/it_IT/process/index.rst      | 68 ++++++++++++++++---
 .../security-bugs.rst                         |  0
 .../it_IT/process/stable-kernel-rules.rst     |  2 +-
 .../it_IT/process/submitting-patches.rst      | 27 ++++++++
 12 files changed, 156 insertions(+), 39 deletions(-)
 rename Documentation/translations/it_IT/{admin-guide => process}/security-bugs.rst (100%)

diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index 5cece223b46b..74057d203539 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -180,9 +180,9 @@ Il valore di ritorno, se c'è, viene descritto in una sezione dedicata di nome
      se provate a formattare bene il vostro testo come nel seguente esempio::
 
 	* Return:
-	* 0 - OK
-	* -EINVAL - invalid argument
-	* -ENOMEM - out of memory
+	* %0 - OK
+	* %-EINVAL - invalid argument
+	* %-ENOMEM - out of memory
 
      le righe verranno unite e il risultato sarà::
 
@@ -192,8 +192,8 @@ Il valore di ritorno, se c'è, viene descritto in una sezione dedicata di nome
      utilizzare una lista ReST, ad esempio::
 
       * Return:
-      * * 0		- OK to runtime suspend the device
-      * * -EBUSY	- Device should not be runtime suspended
+      * * %0		- OK to runtime suspend the device
+      * * %-EBUSY	- Device should not be runtime suspended
 
   #) Se il vostro testo ha delle righe che iniziano con una frase seguita dai
      due punti, allora ognuna di queste frasi verrà considerata come il nome
diff --git a/Documentation/translations/it_IT/process/2.Process.rst b/Documentation/translations/it_IT/process/2.Process.rst
index 25cd00351c03..0a62c0f33faf 100644
--- a/Documentation/translations/it_IT/process/2.Process.rst
+++ b/Documentation/translations/it_IT/process/2.Process.rst
@@ -462,9 +462,12 @@ linux-kernel:
   di far domande.  Molti sviluppatori possono divenire impazienti con le
   persone che chiaramente non hanno svolto i propri compiti a casa.
 
-- Evitate il *top-posting* (cioè la pratica di mettere la vostra risposta sopra
-  alla frase alla quale state rispondendo).  Ciò renderebbe la vostra risposta
-  difficile da leggere e genera scarsa impressione.
+- Rispondete sotto alla porzione di righe citate, così da dare un contesto alle
+  vostre risposte, e quindi renderle più leggibili (in altre parole, evitate di
+  rispondere in cima, ovvero prima del testo citato). Per maggiori dettagli
+  leggete :ref:`Documentation/translations/it_IT/process/submitting-patches.rst
+  <it_interleaved_replies>`.
+
 
 - Chiedete nella lista di discussione corretta.  Linux-kernel può essere un
   punto di incontro generale, ma non è il miglior posto dove trovare
diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Documentation/translations/it_IT/process/4.Coding.rst
index 54fd255b77d0..ec874a8dfb9d 100644
--- a/Documentation/translations/it_IT/process/4.Coding.rst
+++ b/Documentation/translations/it_IT/process/4.Coding.rst
@@ -72,6 +72,10 @@ compiti del genere.  Consultate il file
 :ref:`Documentation/translations/it_IT/process/clang-format.rst <clangformat>`
 per maggiori dettagli
 
+Se utilizzate un programma compatibile con EditorConfig, allora alcune
+configurazioni basilari come l'indentazione e la fine delle righe verranno
+applicate automaticamente. Per maggiori informazioni consultate la pagina:
+https://editorconfig.org/
 
 Livelli di astrazione
 *********************
diff --git a/Documentation/translations/it_IT/process/7.AdvancedTopics.rst b/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
index dffd813a0910..a83fcfe18024 100644
--- a/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
+++ b/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
@@ -160,6 +160,8 @@ preparerà una richiesta nel modo in cui gli altri sviluppatori se l'aspettano,
 e verificherà che vi siate ricordati di pubblicare quelle patch su un
 server pubblico.
 
+.. _development_advancedtopics_reviews_it:
+
 Revisionare le patch
 --------------------
 
@@ -180,6 +182,13 @@ i commenti come domande e non come critiche.  Chiedere "Come viene rilasciato
 il *lock* in questo percorso?" funziona sempre molto meglio che
 "qui la sincronizzazione è sbagliata".
 
+In caso di disaccordi, può essere utile chiedere una terza opinione. Se dopo
+pochi scambi la discussione raggiunge un punto morto, allora chiedete ai
+manutentori o altri revisori di partecipare esprimendo la loro opinione. Spesso
+vige un silenzio assenso per cui gli altri revisori non intervengono se non gli
+viene richiesto esplicitamente. L'opinione di più persone avrà sicuramente un
+peso maggiore.
+
 Diversi sviluppatori revisioneranno il codice con diversi punti di vista.
 Alcuni potrebbero concentrarsi principalmente sullo stile del codice e se
 alcune linee hanno degli spazio bianchi di troppo.  Altri si chiederanno
@@ -189,3 +198,13 @@ l'uso eccessivo di *stack*, problemi di sicurezza, duplicazione del codice
 in altri contesti, documentazione, effetti negativi sulle prestazioni, cambi
 all'ABI dello spazio utente, eccetera.  Qualunque tipo di revisione è ben
 accetta e di valore, se porta ad avere un codice migliore nel kernel.
+
+Non esistono requisiti particolarmente stringenti per l'uso di etichette come
+``Reviewd-by``. Tuttavia, perché la revisione sia efficace ci si aspetta un
+qualche tipo di messaggio che dica "ho verificato A, B e C nel codice che è
+appena stato inviato e mi sembra tutto in ordine". Inoltre, questo permette ai
+manutentori di prendere conoscenza circa una revisione avvenuta per davvero.
+
+Per finire, la revisione delle patch può diventare un processo negativo, troppo
+focalizzato sulla ricerca dei problemi. Provate a fare qualche complimento di
+tanto in tanto, specialmente con i nuovi arrivati.
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index f37c53f8b524..ade695a7de19 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -34,13 +34,15 @@ PC Card, per esempio, probabilmente non dovreste preoccuparvi di pcmciautils.
 ====================== =================  ========================================
 GNU C                  5.1                gcc --version
 Clang/LLVM (optional)  11.0.0             clang --version
+Rust (opzionale)       1.74.1             rustc --version
+bindgen (opzionale)    0.65.1             bindgen --version
 GNU make               3.81               make --version
 bash                   4.2                bash --version
 binutils               2.25               ld -v
 flex                   2.5.35             flex --version
 bison                  2.0                bison --version
 pahole                 1.16               pahole --version
-util-linux             2.10o              fdformat --version
+util-linux             2.10o              mount --version
 kmod                   13                 depmod -V
 e2fsprogs              1.41.4             e2fsck -V
 jfsutils               1.1.3              fsck.jfs -V
@@ -59,8 +61,10 @@ mcelog                 0.6                mcelog --version
 iptables               1.4.2              iptables -V
 openssl & libcrypto    1.0.0              openssl version
 bc                     1.06.95            bc --version
-Sphinx\ [#f1]_         1.7                sphinx-build --version
+Sphinx\ [#f1]_         2.4.4              sphinx-build --version
 cpio                   any                cpio --version
+GNU tar                1.28               tar --version
+gtags (opzionale)      6.6.5              gtags --version
 ====================== =================  ========================================
 
 .. [#f1] Sphinx è necessario solo per produrre la documentazione del Kernel
@@ -151,6 +155,18 @@ Se la firma dei moduli è abilitata, allora vi servirà openssl per compilare il
 kernel 3.7 e successivi.  Vi serviranno anche i pacchetti di sviluppo di
 openssl per compilare il kernel 4.3 o successivi.
 
+Tar
+---
+
+GNU Tar è necessario per accedere ai file d'intestazione del kernel usando sysfs
+(CONFIG_IKHEADERS)
+
+gtags / GNU GLOBAL (opzionale)
+------------------------------
+
+Il programma GNU GLOBAL versione 6.6.5, o successiva, è necessario quando si
+vuole eseguire ``make gtags`` e generare i relativi indici. Internamente si fa
+uso del parametro gtags ``-C (--directory)`` che compare in questa versione.
 
 Strumenti di sistema
 ********************
@@ -434,7 +450,7 @@ E2fsprogs
 JFSutils
 --------
 
-- <http://jfs.sourceforge.net/>
+- <https://jfs.sourceforge.net/>
 
 Reiserfsprogs
 -------------
@@ -455,7 +471,7 @@ Pcmciautils
 Quota-tools
 -----------
 
-- <http://sourceforge.net/projects/linuxquota/>
+- <https://sourceforge.net/projects/linuxquota/>
 
 
 Microcodice Intel P6
@@ -476,7 +492,7 @@ FUSE
 mcelog
 ------
 
-- <http://www.mcelog.org/>
+- <https://www.mcelog.org/>
 
 cpio
 ----
@@ -497,7 +513,8 @@ PPP
 NFS-utils
 ---------
 
-- <http://sourceforge.net/project/showfiles.php?group_id=14>
+- <https://sourceforge.net/project/showfiles.php?group_id=14>
+- <https://nfs.sourceforge.net/>
 
 Iptables
 --------
@@ -512,12 +529,7 @@ Ip-route2
 OProfile
 --------
 
-- <http://oprofile.sf.net/download/>
-
-NFS-Utils
----------
-
-- <http://nfs.sourceforge.net/>
+- <https://oprofile.sf.net/download/>
 
 Documentazione del kernel
 *************************
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 284a75ac19f8..a4b9f44081da 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -214,7 +214,7 @@ Non usate inutilmente le graffe dove una singola espressione è sufficiente.
 
 e
 
-.. code-block:: none
+.. code-block:: c
 
 	if (condition)
 		do_this();
@@ -652,7 +652,7 @@ Quindi, potete sbarazzarvi di GNU emacs, o riconfigurarlo con valori più
 sensati.  Per fare quest'ultima cosa, potete appiccicare il codice che
 segue nel vostro file .emacs:
 
-.. code-block:: none
+.. code-block:: elisp
 
   (defun c-lineup-arglist-tabs-only (ignored)
     "Line up argument lists by tabs, not spaces"
@@ -728,6 +728,10 @@ il testo e altre cose simili.
 Per maggiori dettagli, consultate il file
 :ref:`Documentation/translations/it_IT/process/clang-format.rst <it_clangformat>`.
 
+Se utilizzate un programma compatibile con EditorConfig, allora alcune
+configurazioni basilari come l'indentazione e la fine delle righe verranno
+applicate automaticamente. Per maggiori informazioni consultate la pagina:
+https://editorconfig.org/
 
 10) File di configurazione Kconfig
 ----------------------------------
@@ -898,7 +902,9 @@ usare per assicurarvi che i messaggi vengano associati correttamente ai
 dispositivi e ai driver, e che siano etichettati correttamente:  dev_err(),
 dev_warn(), dev_info(), e così via.  Per messaggi che non sono associati ad
 alcun dispositivo, <linux/printk.h> definisce pr_info(), pr_warn(), pr_err(),
-eccetera.
+eccetera. Quando tutto funziona correttamente, non dovrebbero esserci stampe,
+per cui preferite dev_dbg/pr_debug a meno che non sia qualcosa di sbagliato
+da segnalare.
 
 Tirar fuori un buon messaggio di debug può essere una vera sfida; e quando
 l'avete può essere d'enorme aiuto per risolvere problemi da remoto.
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index ba0ed7dc154c..d4ab76e9be49 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -86,7 +86,7 @@ da kcalloc().
 Se questo tipo di allocatore non è disponibile, allora dovrebbero essere usate
 le funzioni del tipo *saturate-on-overflow*::
 
-	bar = vmalloc(array_size(count, size));
+	bar = dma_alloc_coherent(dev, array_size(count, size), &dma, GFP_KERNEL);
 
 Un altro tipico caso da evitare è quello di calcolare la dimensione di una
 struttura seguita da un vettore di altre strutture, come nel seguente caso::
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 052f1b3610cb..090941a0a898 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -85,8 +85,8 @@ relativi file di documentatione che spiegano come usarele.
 Quando un cambiamento del kernel genera anche un cambiamento nell'interfaccia
 con lo spazio utente, è raccomandabile che inviate una notifica o una
 correzione alle pagine *man* spiegando tale modifica agli amministratori di
-queste pagine all'indirizzo mtk.manpages@gmail.com, aggiungendo
-in CC la lista linux-api@vger.kernel.org.
+queste pagine all'indirizzo alx@kernel.org, aggiungendo in CC la
+lista linux-api@vger.kernel.org.
 
 Di seguito una lista di file che sono presenti nei sorgente del kernel e che
 è richiesto che voi leggiate:
@@ -144,7 +144,7 @@ Di seguito una lista di file che sono presenti nei sorgente del kernel e che
     dello sviluppo di Linux ed è molto importante per le persone che arrivano
     da esperienze con altri Sistemi Operativi.
 
-  :ref:`Documentation/translations/it_IT/admin-guide/security-bugs.rst <it_securitybugs>`
+  :ref:`Documentation/translations/it_IT/process/security-bugs.rst <it_securitybugs>`
     Se ritenete di aver trovato un problema di sicurezza nel kernel Linux,
     seguite i passaggi scritti in questo documento per notificarlo agli
     sviluppatori del kernel, ed aiutare la risoluzione del problema.
diff --git a/Documentation/translations/it_IT/process/index.rst b/Documentation/translations/it_IT/process/index.rst
index cd7977905fb8..73c643dcc541 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -21,19 +21,75 @@ l'accettazione delle vostre modifiche con il minimo sforzo.
 
 Di seguito le guide che ogni sviluppatore dovrebbe leggere.
 
+Introduzione al funzionamento dello sviluppo del kernel
+-------------------------------------------------------
+
+Innanzitutto, leggete questi documenti che vi aiuteranno ad entrare nella
+comunità del kernel.
+
 .. toctree::
    :maxdepth: 1
 
    howto
-   code-of-conduct
    development-process
    submitting-patches
+   submit-checklist
+
+Strumenti e guide tecniche per gli sviluppatori del kernel
+----------------------------------------------------------
+
+Quella che segue è una raccolta di documenti che uno sviluppatore del kernel
+Linux dovrebbe conoscere.
+
+.. toctree::
+   :maxdepth: 1
+
+   changes
    programming-language
    coding-style
    maintainer-pgp-guide
    email-clients
+   applying-patches
+   adding-syscalls
+   volatile-considered-harmful
+   botching-up-ioctls
+
+Politiche e dichiarazioni degli sviluppatori
+--------------------------------------------
+
+Quelle che seguono rappresentano le regole che cerchiamo di seguire all'interno
+della comunità del kernel (e oltre).
+
+.. toctree::
+   :maxdepth: 1
+
+   code-of-conduct
    kernel-enforcement-statement
    kernel-driver-statement
+   stable-api-nonsense
+   stable-kernel-rules
+   management-style
+
+Gestire i bachi
+---------------
+
+I bachi sono parte della nostra vita; dunque è importante che vengano trattati
+con riguardo. I documenti che seguono descrivono le nostre politiche riguardo al
+trattamento di alcune classi particolari di bachi: le regressioni e i problemi
+di sicurezza.
+
+Informazioni per i manutentori
+------------------------------
+
+Come trovare le persone che accetteranno le vostre modifiche.
+
+.. toctree::
+   :maxdepth: 1
+
+   maintainers
+
+Altri documenti
+---------------
 
 Poi ci sono altre guide sulla comunità che sono di interesse per molti
 degli sviluppatori:
@@ -41,13 +97,7 @@ degli sviluppatori:
 .. toctree::
    :maxdepth: 1
 
-   changes
-   stable-api-nonsense
-   management-style
-   stable-kernel-rules
-   submit-checklist
    kernel-docs
-   maintainers
 
 Ed infine, qui ci sono alcune guide più tecniche che son state messe qua solo
 perché non si è trovato un posto migliore.
@@ -55,11 +105,7 @@ perché non si è trovato un posto migliore.
 .. toctree::
    :maxdepth: 1
 
-   applying-patches
-   adding-syscalls
    magic-number
-   volatile-considered-harmful
-   botching-up-ioctls
    clang-format
    ../riscv/patch-acceptance
 
diff --git a/Documentation/translations/it_IT/admin-guide/security-bugs.rst b/Documentation/translations/it_IT/process/security-bugs.rst
similarity index 100%
rename from Documentation/translations/it_IT/admin-guide/security-bugs.rst
rename to Documentation/translations/it_IT/process/security-bugs.rst
diff --git a/Documentation/translations/it_IT/process/stable-kernel-rules.rst b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
index 248bf1e4b171..a2577a806a18 100644
--- a/Documentation/translations/it_IT/process/stable-kernel-rules.rst
+++ b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
@@ -44,7 +44,7 @@ Procedura per sottomettere patch per i sorgenti -stable
 .. note::
   Una patch di sicurezza non dovrebbe essere gestita (solamente) dal processo
   di revisione -stable, ma dovrebbe seguire le procedure descritte in
-  :ref:`Documentation/translations/it_IT/admin-guide/security-bugs.rst <it_securitybugs>`.
+  :ref:`Documentation/translations/it_IT/process/security-bugs.rst <it_securitybugs>`.
 
 Per tutte le altre sottomissioni, scegliere una delle seguenti procedure
 ------------------------------------------------------------------------
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index f91c8092844f..4c6a276bdc08 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -349,6 +349,33 @@ Leggete Documentation/translations/it_IT/process/email-clients.rst per
 le raccomandazioni sui programmi di posta elettronica e l'etichetta da usare
 sulle liste di discussione.
 
+.. _it_interleaved_replies:
+
+Rispondere alle email in riga e riducendo la citazioni
+------------------------------------------------------
+
+Nelle discussioni riguardo allo sviluppo del kernel viene fortemente scoraggiato
+l'uso di risposte in cima ai messaggi di posta elettronica. Rispondere in riga
+rende le conversazioni molto più scorrevoli. Maggiori dettagli possono essere
+trovati qui: https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
+
+Come spesso citato nelle liste di discussione::
+
+  R: http://en.wikipedia.org/wiki/Top_post
+  D: Dove posso trovare informazioni riguardo alle "risposte in cima"?
+  R: Perché incasina il normale ordine con cui si legge un testo.
+  D: Perché è così terribile rispondere in cima?
+  R: Risposte in cima.
+  Q: Qual è la cosa più fastidiosa nei messaggi di posta elettronica?
+
+Allo stesso modo, per favore eliminate tutte le citazioni non necessarie per la
+vostra risposta. Questo permette di trovare più facilmente le risposte, e
+permette di risparmiare tempo e spazio. Per maggiori dettagli:
+http://daringfireball.net/2007/07/on_top ::
+
+  R: No.
+  D: Dovrei includere un blocco di citazione dopo la mia risposta?
+
 .. _it_resend_reminders:
 
 Non scoraggiatevi - o impazientitevi
-- 
2.39.2


